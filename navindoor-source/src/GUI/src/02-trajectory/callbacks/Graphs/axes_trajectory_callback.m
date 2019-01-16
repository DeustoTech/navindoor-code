function axes_trajectory_callback(object,event,h)
%% ButtonDown_Trayectory
% Funcion que se lanza cuando se hace click en iurgui y el panel de trayectorias esta seleccionado

    %% Vadidations 
    %tab_trajectory = findobj_figure(h.iur_figure,'tabgroup','Trajectory');
    
    %list_box_levels = findobj_figure(tab_trajectory,'Levels','listbox');
    list_box_levels = h.iur_figure.Children(1).Children(2).Children(2).Children(1).Children;
    index_level = list_box_levels.Value;

    %list_box_straj = findobj_figure(tab_trajectory,'Supertraj','listbox');
    list_box_straj = h.iur_figure.Children(1).Children(2).Children(4).Children(3);
    index_straj = list_box_straj.Value;


    option = h.javacomponets.trajectory_layer.btngrp_option.getSelection.getActionCommand();
    option = [option.toCharArray]';

    C = object.CurrentPoint;
    
    height = h.planimetry_layer(index_level).height;
    ipoint = point([C(1,1),C(1,2) height]);

   
    %% Star function
    traj_layer  = h.trajectory_layer(index_straj);

    if ~isempty(traj_layer.traj)
       result = questdlg('A trajectory already exists. Do you want to delete the previous trajectory?');
       if strcmp(result,'Cancel')||strcmp(result,'No')
           return
       else 
           %edit_box_Generate = findobj_figure(h.iur_figure,'Trajectory','Info Objects','Generate:');           %edit_box_Generate.BackgroundColor = [1 0 0];
           %edit_box_Generate.String = 'FALSE';
           delete_traj(traj_layer)
       end
    end
    %% choose mode 
    switch option 
        case 'insert'
            if isempty(traj_layer.points)
                traj_layer.points = [traj_layer.points ipoint];
            else
                last_point = traj_layer.points(end);
                %%
                if last_point.z == ipoint.z
                    % dentro de un planta comprobamos que no atravezamos paredes sin puertas 
                    try_wall = wall([node(last_point.r) node(ipoint.r)]);
                    for iwall = h.planimetry_layer(index_level).walls
                         if crossdoors(iwall,try_wall)
                            return
                         end
                    end
                    traj_layer.points = [traj_layer.points ipoint];

                else
                    % Comprobamos que el final esta cerca de una escalera o elevador. 
                    % Si es asi creamos nuevos puntos que pasan por los elevadores/escaleras 
                    [~,index_init] = min(abs([h.planimetry_layer.height] - last_point.z));
                    [~,index_end]  = min(abs([h.planimetry_layer.height] - ipoint.z));
                    
                    stai_init = h.planimetry_layer(index_init).stairs;
                    elev_init = h.planimetry_layer(index_init).elevators;
                    
                    stai_end  = h.planimetry_layer(index_end).stairs;
                    elev_end  = h.planimetry_layer(index_end).elevators;
                    
                    % Comprobamos que exista alguna manera de cambiar de planta,
                    % en la planta inicial y la final, debe haber al menos una 
                    % escalera o elevador
                    if (isempty(stai_init) && isempty(elev_init))||(isempty(stai_end) && isempty(elev_end))
                       errordlg('No existen ninguna escalera, ni elevador para subir de planta!','Error','modal') 
                       return 
                    end
                    % Si hay alguna forma de cambiar de planta, calculamos si hay algun elevador o escalera cerca
                    
                    % calculamos la distancia del punto inicial a todos los elevadores
                    precision = 5;
                    pi = search_elevator_stairs(elev_init,stai_init,last_point,precision);
                    pf = search_elevator_stairs(elev_end,stai_end,ipoint,precision);
                    
                    if isempty(pi)||isempty(pf)
                       return 
                    end
                    traj_layer.points = [traj_layer.points pi pf ipoint ];
                                        
                end 
            end
            
        case 'select'

    end

    update_trajectory_layer(h,'onlyclick',true)

    function ri = search_elevator_stairs(elev,stai,ipoint,precision)
        min_elevator_init = Inf;
        min_stairs_init = Inf;
        %%
        if ~isempty(elev)
            [min_elevator_init,index_elevator_init] = min(arrayfun(@(ielevator) norm(ielevator.r(1:2) - ipoint.r(1:2)),elev));
        end
        %%
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




