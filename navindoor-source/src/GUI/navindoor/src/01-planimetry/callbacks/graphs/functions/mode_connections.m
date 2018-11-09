function connection_ButtonDown(vb1,cnode,option,precision,index_level)
%CONNECTION_BUTTONDOWN Summary of this function goes here
%   Detailed explanation goes here
%% ID: 20180614-gui-NewConnectionsClass

% Title____:    Cambiamos la clase wall, por la clase connection que es un hijo de wall. 
% Date_____:    04/06/2018
% Reason___:    La propiedad build.connections = [0x0 wall], causaba confucion por lo que se ha creado 
%               una clase connection para que la remplaze. En principio, la clase tiene las misma propiedades
%               ya que es un hijo de wall. Entonces connections queda como build.connections = [0x0 connection]

    switch option
        %% INPUT OPTION
        case 'insert'
            %% Validation
            if ~(~isempty(vb1.elevators) || ~isempty(vb1.select_elevators) || ~isempty(vb1.stairs) || ~isempty(vb1.select_stairs)) 
                % ================ %
                return % <= END == %
                % ================ %
            end

            %% View that type of element was selected
            if ~isempty(vb1.elevators) || ~isempty(vb1.select_elevators)
                elevators = vb1.elevators([vb1.elevators.level] == index_level - 1);
                if ~isempty(elevators) || ~isempty(vb1.select_elevators)
                    result_elevators = select_node(elevators,vb1.select_elevators,cnode,precision);
                    other_level_elevators =  vb1.elevators([vb1.elevators.level] ~= index_level - 1);
                    result_elevators.nodes = [result_elevators.nodes other_level_elevators];
                end
            end

            if ~isempty(vb1.stairs) || ~isempty(vb1.select_stairs)
                stairs = vb1.stairs([vb1.stairs.level] == index_level - 1);
                if ~isempty(stairs) || ~isempty(vb1.select_stairs)
                    result_stairs = select_node(stairs,vb1.select_stairs,cnode,precision);  
                    other_level_stairs =  vb1.stairs([vb1.stairs.level] ~= index_level - 1);
                    result_stairs.nodes = [result_stairs.nodes other_level_stairs];
                end
            end

            if exist('result_stairs','var') && exist('result_elevators','var')
                if result_elevators.distance > result_stairs.distance
                    element_type = 'stairs';
                else
                    element_type = 'elevator';
                end
            elseif exist('result_stairs','var')
                    element_type = 'stairs';

            elseif exist('result_elevators','var')
                    element_type = 'elevator';
            end
            
           % Si ha se ha seleccionado alguno 
           % el Switch encontrara que tipo de elemento se ha seleccionado 
           % elevador o escalera
           switch element_type
               case 'elevator'
                   if isempty(vb1.select_elevators) && isempty(vb1.select_stairs)
                       vb1.elevators = result_elevators.nodes;
                       vb1.select_elevators = result_elevators.select_nodes;
                   elseif ~isempty(vb1.select_stairs)
                       vb1.stairs = [vb1.stairs vb1.select_stairs];
                       vb1.select_stairs =[];
                       vb1.elevators = result_elevators.nodes;
                       vb1.select_elevators = result_elevators.select_nodes; 
                   elseif ~isempty(vb1.select_elevators)
                       vb1.elevators = result_elevators.nodes;
                       vb1.select_elevators = result_elevators.select_nodes; 
                   end
               case 'stairs'
                   if isempty(vb1.select_elevators) && isempty(vb1.select_stairs)
                       vb1.stairs = result_stairs.nodes;
                       vb1.select_stairs = result_stairs.select_nodes;
                   elseif ~isempty(vb1.select_elevators)
                       vb1.elevators = [vb1.elevators vb1.select_elevators];
                       vb1.select_elevators =[];
                       vb1.stairs = result_stairs.nodes;
                       vb1.select_stairs = result_stairs.select_nodes; 
                   elseif ~isempty(vb1.select_stairs)
                       vb1.stairs = result_stairs.nodes;
                       vb1.select_stairs = result_stairs.select_nodes; 
                   end
           end

            %% Creation connections of elevators
            % si no hay seleccionado dos elevadores no se puede crear la conneccion 
            if length(vb1.select_elevators)==2        
                new_wall = connection([vb1.select_elevators(1),vb1.select_elevators(2)]);
                exist_wall = false;
               for iwall=[ vb1.connections vb1.select_connections ]
                   if iwall == new_wall
                      exist_wall=true; 
                   end
               end
               same_level =false;

               % comrobate that the nodes are the two distinct
               % levels 
               if new_wall.nodes(1).level == new_wall.nodes(2).level
                    same_level = true;
               end

              % only can create a connection between two consecutive levels
              consecutive_level = false;
              if new_wall.nodes(1).level == new_wall.nodes(2).level + 1 ...
               || new_wall.nodes(1).level == new_wall.nodes(2).level - 1
                  consecutive_level = true;
              end
               
               if ~exist_wall  
                   if ~same_level
                       if consecutive_level
                            vb1.connections = [ vb1.connections new_wall ];  
                            vb1.elevators = [vb1.elevators vb1.select_elevators ];
                            vb1.select_elevators = [];
                        return
                       end
                   end
               end
               % If connection haven't been create, so unselect the first
               % element
               vb1.elevators = [vb1.elevators vb1.select_elevators(1) ];
               vb1.select_elevators(1) = []; 
            end
            
            %% Creation connections of staris
            % si no hay seleccionado dos staris no se puede crear la conneccion 
            if length(vb1.select_stairs)==2 
                new_wall = connection([vb1.select_stairs(1),vb1.select_stairs(2)]);
                exist_wall = false;
                for iwall=[ vb1.connections vb1.select_connections ]
                   if iwall == new_wall
                      exist_wall=true; 
                   end
                end
               same_level =false;
               % comrobate that the nodes are the two distinct
               % levels 
               if new_wall.nodes(1).level == new_wall.nodes(2).level
                    same_level = true;
               end
              % only can create a connection between two consecutive levels
              consecutive_level = false;
              if new_wall.nodes(1).level == new_wall.nodes(2).level + 1 ...
               || new_wall.nodes(1).level == new_wall.nodes(2).level - 1
                  consecutive_level = true;
              end

               if ~exist_wall  
                   if ~same_level
                       if consecutive_level
                        vb1.connections = [ vb1.connections new_wall ];           
                        vb1.stairs = [vb1.stairs vb1.select_stairs ];
                        vb1.select_stairs = []; 
                        return
                       end
                   end
               end

               vb1.stairs = [vb1.stairs vb1.select_stairs(1) ];
               vb1.select_stairs(1) = []; 
            end
            
            
        %% SELECT OPTION
        case 'select'
            if ~isempty(vb1.connections) || ~isempty(vb1.select_connections)
                result = select_wall(vb1.connections,vb1.select_connections,cnode,precision);  
                vb1.connections = result{1};
                vb1.select_connections = result{2};
            end
    end  
end

