%AXES_TRAJECTORY_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
%% ID: 20180614-gui-Supertraj_No_Consecutive_Level_Restriction
% =================================
% Title____:    Agregamos funcionalidad para que sea posible pasar a plantas no consecutivas 
% Date_____:    04/06/2018
% Reason___:    Problema de pasar de la planta 1 a la 3, ya que sería necenario crea una trajectoria 
%               minima de dos punto los que hace que en un elevador no sea posible pasar entre plantas 
%               no consecutivas
%
%% ID: 20180619-gui-
% =================================
% Title____:    Agregamos funcionalidad para que sea posible pasar a plantas no consecutivas 
% Date_____:    19/06/2018
% Reason___:    Problema de pasar de la planta 1 a la 3, ya que sería necenario crea una trajectoria 
%               minima de dos punto los que hace que en un elevador no sea posible pasar entre plantas 
%               no consecutivas
%
function axes_trajectory_callback(object,event,h)
%% ButtonDown_Trayectory
% Funcion que se lanza cuando se hace click en iurgui y el panel de trayectorias esta seleccionado

    %% Vadidations 
    
    % Valid if exist a straj container
    
    list_box_levels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Levels','listbox');
    index_level = list_box_levels.Value;

    list_box_straj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
    index_straj = list_box_straj.Value;


    option = h.javacomponets.trajectory_layer.btngrp_option.getSelection.getActionCommand();
    option = [option.toCharArray]';
    mode   = h.javacomponets.trajectory_layer.btngrp_mode.getSelection.getActionCommand();
    mode = [mode.toCharArray]';

    C = object.CurrentPoint;
    cvertex = vertex([C(1,1),C(1,2)]);   

    vb = h.planimetry_layer(index_level);
    precision = (0.005 *  sqrt( (object.XLim(2)-object.XLim(1))^2 + (object.YLim(2)-object.YLim(1))^2 ));
    
   
    %% Star function
     ilevel = h.planimetry_layer(1).build.levels(index_level);
    straj  = h.trajectory_layer(index_straj);
    building = h.planimetry_layer(1).build;
    cvertex.level = index_level-1;
    % solo ejecutamos el codigo 

   

    %% choose mode 
    switch option 
        case 'insert'
        %%
            % 
            
            if ~isempty(straj.vertexs)

                % cvertex no puede ser igual que el ultimo nodo agregado
                % si lo fuera retornamos 
                if (cvertex == straj.vertexs(end))
                   return  
                end
                % creamos una objeto itraj, que representa el ultimo tramo que se quiere crear
                itraj = traj([straj.vertexs(end) cvertex],'hold_nodes',true);

                % en el caso de que los dos ultimo nodos pertenezcan al mismo nivel 
                % simplemente comprobamos que no atravieze ninguna pared, si esto se 
                % cumple lo agregamos a la lista straj.vertexs.
                if itraj.nodes(1).level == itraj.nodes(2).level && trajoflevel(itraj,ilevel)   
                    straj.vertexs = [straj.vertexs cvertex];  
                else
                % Comprobamos que se ha selecionado algun elevator o stairs
                % [ p = si se ha selecionado, pnode = si se ha selecionado, tendra el elevator o stair ]
                    [p1, p1node] = select_elevators_or_stairs(itraj.nodes(1)); % interfunction
                    [p2, p2node] = select_elevators_or_stairs(itraj.nodes(2)); % interfunction
                
                % si no se han seleccionado alguno nada en alguno de los dos niveles 
                % no se puede crear connecition por lo que retornamos
                    if ~(p1 && p2)
                        return
                    end
                    
                % si los nodos seleccionados no son de la misma clase (elevator = elevator) o (stairs = stairs)
                % retornamos sin hacer nada 
                    if ~strcmp(class(p1node),class(p2node))
                        return
                    end
                
                %% ID: 20180614-gui-Supertraj_No_Consecutive_Level_Restriction
                % for and if comentado - posible error
                    trajwall = connection([p1node,p2node]);
                %    for conn = building.connections
                %        if conn == trajwall
                            straj.vertexs = [straj.vertexs cvertex];
                            straj.connections = [straj.connections trajwall];
                %            break
                %        end
                %    end
                end
            else
                straj.vertexs = [straj.vertexs cvertex];
            end
        case 'select'
        %%

    end

    
    generate_supertraj(h);
    update_trajectory_layer(h)
    
    % END
    %
    %
    %    
    %   .----------------. .----------------. .-----------------..----------------. .----------------. 
    % | .--------------. | .--------------. | .--------------. | .--------------. | .--------------. |
    % | |  _________   | | | _____  _____ | | | ____  _____  | | |     ______   | | |    _______   | |
    % | | |_   ___  |  | | ||_   _||_   _|| | ||_   \|_   _| | | |   .' ___  |  | | |   /  ___  |  | |
    % | |   | |_  \_|  | | |  | |    | |  | | |  |   \ | |   | | |  / .'   \_|  | | |  |  (__ \_|  | |
    % | |   |  _|      | | |  | '    ' |  | | |  | |\ \| |   | | |  | |         | | |   '.___`-.   | |
    % | |  _| |_       | | |   \ `--' /   | | | _| |_\   |_  | | |  \ `.___.'\  | | |  |`\____) |  | |
    % | | |_____|      | | |    `.__.'    | | ||_____|\____| | | |   `._____.'  | | |  |_______.'  | |
    % | |              | | |              | | |              | | |              | | |              | |
    % | '--------------' | '--------------' | '--------------' | '--------------' | '--------------' |
    %  '----------------' '----------------' '----------------' '----------------' '----------------' 
    function [p, pnode] = select_elevators_or_stairs(inode)
        p = false;
        pnode=[];

        %%
        % Stairs y Elevators de el nivel del primer nodo, es decir;
        % la del nivel de donde se viene 

        elevators  = building.levels(inode.level + 1).elevators;
        stairs     = building.levels(inode.level + 1).stairs;

        select_elevators = [];
        select_stairs    = [];

        % se intenta selecciona elvators o starirs con el nodo en el nivel de donde 
        % se viene
        result = select_node(elevators,select_elevators,inode,precision);
        if isempty(result.select_nodes)
            result = select_node(stairs,select_stairs,inode,precision);
        end

        % Si se ha seleccionado algun elevator o stairs 
        if ~isempty(result.select_nodes)
            pnode = result.select_nodes;
            p = true;
        end
    end
    

    %   .----------------. .----------------. .----------------. .----------------. .----------------. 
    % | .--------------. | .--------------. | .--------------. | .--------------. | .--------------. |
    % | | ____   ____  | | |      __      | | |   _____      | | |     _____    | | |  ________    | |
    % | ||_  _| |_  _| | | |     /  \     | | |  |_   _|     | | |    |_   _|   | | | |_   ___ `.  | |
    % | |  \ \   / /   | | |    / /\ \    | | |    | |       | | |      | |     | | |   | |   `. \ | |
    % | |   \ \ / /    | | |   / ____ \   | | |    | |   _   | | |      | |     | | |   | |    | | | |
    % | |    \ ' /     | | | _/ /    \ \_ | | |   _| |__/ |  | | |     _| |_    | | |  _| |___.' / | |
    % | |     \_/      | | ||____|  |____|| | |  |________|  | | |    |_____|   | | | |________.'  | |
    % | |              | | |              | | |              | | |              | | |              | |
    % | '--------------' | '--------------' | '--------------' | '--------------' | '--------------' |
    %  '----------------' '----------------' '----------------' '----------------' '----------------' 
    
    function error = exist_straj(handles)
        error = false; 
        if isempty(handles.view_straj)
            msg = 'Create a supertraj to add vertexs. Clicking in add botton of supertrajs panel';            
            error_box(handles,msg,'r')
            error = true;
        end
    end

end




