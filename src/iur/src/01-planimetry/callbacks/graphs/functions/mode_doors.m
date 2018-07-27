function mode_doors(vb,cnode,option,precision,index_level)
%MODE_DOORS Summary of this function goes here
%   Detailed explanation goes here
    switch option 
        case 'insert'
            if ~isempty(vb.walls)
                result = select_wall(vb.walls,vb.select_walls,cnode,precision);
                vb.walls = result{1};
                vb.select_walls = result{2};
                pnode = result{3};
                if ~isempty(vb.select_walls)
                    cdoor = door(pnode);
                    cdoor.level = index_level - 1;
                    vb.select_walls(1).doors = [vb.select_walls(1).doors cdoor];
                    vb.doors = [ vb.doors cdoor];
                    vb.walls = [ vb.walls vb.select_walls(1)];
                    vb.select_walls = [];
                end
            end
        case 'select'
            if ~isempty(vb.doors) || ~isempty(vb.select_doors)

                result = select_node(vb.doors,vb.select_doors,cnode,precision);
                vb.doors = result.nodes;
                vb.select_doors = result.select_nodes;
            end
    end 
end

