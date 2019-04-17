function axes_trajectory_callback(object,event,h)
%% ButtonDown_Trayectory
% Funcion que se lanza cuando se hace click en iurgui y el panel de trayectorias esta seleccionado

    if isempty(h.trajectory_layer)
      errordlg('Crear una trajectoria') 
      return
    end
    %%    
    list_box_buildings  = h.DirectAccess.Trajectory.Navigation.Buildings;
    list_box_levels     = h.DirectAccess.Trajectory.Navigation.Levels;
    
    IndexBuilding       = list_box_buildings.Value;
    index_level         = list_box_levels.Value;

    list_box_traj       = h.DirectAccess.Trajectory.Trajectories.listbox;
    index_straj         = list_box_traj.Value;

    C = object.CurrentPoint;
    
    imap = h.planimetry_layer.map;
    
    ClickIndexBuilding = xy2indexbuilding(imap,[C(1,1) C(1,2)]);

    %% Altura
    InOut_ListBox =  h.DirectAccess.Trajectory.Navigation.InOut;
    
    InOut = InOut_ListBox.String{InOut_ListBox.Value};
    
    %% Validaciones Click y Seleccion coherentes
    switch InOut 
        case '--In--'
             if isempty(ClickIndexBuilding)
                 errordlg('Click Indoor!')
                 return
             elseif ClickIndexBuilding ~= IndexBuilding
                 errordlg('Click In correct Building!')
                 return
             end           
        case '-Out-'
            if ~isempty(ClickIndexBuilding)
               errordlg('Click Out!')
               return
            end
    end
    
    %% Validaciones - Borrar la trayectoria previa
    traj_layer  = h.trajectory_layer(index_straj);

    if ~isempty(traj_layer.traj)
       result = questdlg('A trajectory already exists. Do you want to delete the previous trajectory?');
       if strcmp(result,'Cancel')||strcmp(result,'No')
           return
       else 
           delete_traj(traj_layer)
       end
    end

    %% Empezamos la construccion
    
    if isempty(traj_layer.points)
        %% El primer punto
        if isempty(ClickIndexBuilding)
            ipoint          = point([C(1,1),C(1,2),0]);
        else
            levels                  = imap.buildings(IndexBuilding).levels;
            index_level             = list_box_levels.Value;
            ipoint                  = point([C(1,1),C(1,2),levels(index_level).height]);
            ipoint.IndexBuilding    = IndexBuilding;
            ipoint.IndexLevel       = index_level;
        end
        traj_layer.points           = [traj_layer.points ipoint];
    else
        %% Si existe ya un punto. Los posible caminos solo dependen del punto anterior
        last_point          = traj_layer.points(end);

        if isempty(ClickIndexBuilding)
            ipoint          = point([C(1,1),C(1,2),0]);
           
        else
            levels      = imap.buildings(IndexBuilding).levels;
            index_level = list_box_levels.Value;
            ipoint      = point([C(1,1),C(1,2),levels(index_level).height]);
            ipoint.IndexBuilding    = IndexBuilding;
            ipoint.IndexLevel       = index_level;
        end
        
        if (last_point.z == ipoint.z)||(last_point.IndexBuilding ~= ipoint.IndexBuilding)
            % dentro de un planta comprobamos que no atravezamos paredes sin puertas 
            try_wall = wall([node(last_point.r) node(ipoint.r)]);

            %% Seleccion de walls segun vas de in/out | out/out | in/in 
            if last_point.IndexBuilding == -100
                switch InOut
                    case '--In--'
                        walls = imap.buildings(IndexBuilding).levels(index_level).walls;
                    case '-Out-'
                        borders = [imap.buildings.border];
                        walls = [borders.walls];
                end
            else
                walls = imap.buildings(IndexBuilding).levels(index_level).walls;
            end
            %%
            rdoor = [];
            for iwall = walls
                 [boolean,r] = crossdoors(iwall,try_wall);

                 if boolean
                    return
                 else
                    if ~isempty(r)
                        rdoor = r;
                    end
                 end
            end

            if ~isempty(rdoor)
                idoor = copy(ipoint);
                idoor.x = rdoor(1);
                idoor.y = rdoor(2);
                traj_layer.points = [traj_layer.points idoor ipoint];
            else
                traj_layer.points = [traj_layer.points ipoint];
            end
        else
                    % Comprobamos que el final esta cerca de una escalera o elevador. 
                    % Si es asi creamos nuevos puntos que pasan por los elevadores/escaleras 
                    height = imap.buildings(IndexBuilding).levels(index_level).height;
                    [~,index_init] = min(abs([height] - last_point.z));
                    [~,index_end]  = min(abs([height] - ipoint.z));
                    
                    stai_init = imap.buildings(IndexBuilding).levels(index_init).stairs;
                    elev_init = imap.buildings(IndexBuilding).levels(index_init).elevators;
                    
                    stai_end  = imap.buildings(IndexBuilding).levels(index_end).stairs;
                    elev_end  = imap.buildings(IndexBuilding).levels(index_end).elevators;
                    
                    % Comprobamos que exista alguna manera de cambiar de planta,
                    % en la planta inicial y la final, debe haber al menos una 
                    % escalera o elevador
                    if (isempty(stai_init) && isempty(elev_init))||(isempty(stai_end) && isempty(elev_end))
                       errordlg('No existen ninguna escalera, ni elevador para subir de planta!','Error','modal') 
                       return 
                    end
                    % Si hay alguna forma de cambiar de planta, calculamos si hay algun elevador o escalera cerca
                    
                    % calculamos la distancia del punto inicial a todos los elevadores
                    precision = 20;
                    pi = search_elevator_stairs(elev_init,stai_init,last_point,precision);
                    pf = search_elevator_stairs(elev_end,stai_end,ipoint,precision);
                    
                    if isempty(pi)||isempty(pf)
                       return 
                    end
                    traj_layer.points = [traj_layer.points pi pf ipoint ];
                                        
                end 
            end
            


    update_trajectory_layer(h,'onlyclick',true)
%%



%%


%%


%%
    function ri = search_elevator_stairs(elev,stai,ipoint,precision)
        % Subfuncion que busca el elvador o ascensor mas cercano a un punto
        % ipoint 
        min_elevator_init = Inf;
        min_stairs_init = Inf;
        %
        if ~isempty(elev)
            [min_elevator_init,index_elevator_init] = min(arrayfun(@(ielevator) norm(ielevator.r(1:2) - ipoint.r(1:2)),elev));
        end
        %
        if ~isempty(stai)
            [min_stairs_init,index_stairs_init] = min(arrayfun(@(ielevator) norm(ielevator.r(1:2) - ipoint.r(1:2)),stai));
        end
        %%
        
        if min_stairs_init < min_elevator_init
            min_distance = min_stairs_init;
            ri = point(stai(index_stairs_init).r);
        else
            min_distance = min_elevator_init;
            ri = point(elev(index_elevator_init).r);
        end
        
        if min_distance > precision
            ri = [];
        end
        
    end
end




