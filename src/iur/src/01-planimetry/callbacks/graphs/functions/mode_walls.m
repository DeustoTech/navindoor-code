function mode_walls(vb,cnode,option,precision,index_level)
%INSERT_WALLS Summary of this function goes here
%   Detailed explanation goes here
    
    switch option
        case 'insert'
            if ~isempty(vb.nodes) || ~isempty(vb.select_nodes)
                result = select_node(vb.nodes,vb.select_nodes,cnode,precision);  
                vb.nodes = result.nodes;
                vb.select_nodes = result.select_nodes;
                if length(vb.select_nodes)==2
                    new_wall = wall([vb.select_nodes(1),vb.select_nodes(2)]);
                    exist_wall = false;
                   for iwall=[ vb.walls vb.select_walls ]
                       if iwall == new_wall
                          exist_wall=true; 
                       end
                   end

                   if ~exist_wall
                        new_wall.level = index_level - 1;
                        vb.walls = [ vb.walls new_wall ];                 
                   end
                   vb.nodes = [vb.nodes vb.select_nodes(1) ];
                   vb.select_nodes(1) = []; 
                end
            end
        case 'select'
            if ~isempty(vb.walls) || ~isempty(vb.select_walls)
                result = select_wall(vb.walls,vb.select_walls,cnode,precision);  
                vb.walls = result{1};
                vb.select_walls = result{2};
            end
    end
    

