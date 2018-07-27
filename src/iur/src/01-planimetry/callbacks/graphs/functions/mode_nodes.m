function mode_nodes(vb,cnode,option,precision,index_level)
%INSERT_NODES Summary of this function goes here
%   Detailed explanation goes here

    switch option 
        case 'insert'
            if ~isempty(vb.walls) 
                result = select_wall(vb.walls,vb.select_walls,cnode,precision);  
                vb.walls = result{1};
                vb.select_walls = result{2};

                if ~isempty(vb.select_walls) 
                     n1 = vb.select_walls(1).nodes(1);
                     n2 = vb.select_walls(1).nodes(2);
                     pnode = result{3};
                     vb.nodes = [vb.nodes pnode];
                     vb.walls = [vb.walls wall([n1 pnode]) wall([n2 pnode])];
                     vb.select_walls = [];
                else
                    vb.nodes = [vb.nodes cnode];
                end

            else
                vb.nodes = [vb.nodes cnode];
            end
        case 'select'
            if ~isempty(vb.nodes) || ~isempty(vb.select_nodes)
                result = select_node(vb.nodes,vb.select_nodes,cnode,precision);
                vb.nodes = result.nodes;
                vb.select_nodes = result.select_nodes;
            end
    end
end

