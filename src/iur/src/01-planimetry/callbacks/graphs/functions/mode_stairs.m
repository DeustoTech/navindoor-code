function stairs_ButtonDown(vb1,cnode,option,precision,index_level)
    cstair = stairs;
    cstair.r = cnode.r;
    cstair.level = index_level - 1;            
    switch option 
        case 'insert'
            vb1.stairs = [vb1.stairs cstair];
        case 'select'
            if ~isempty(vb1.stairs) || ~isempty(vb1.select_stairs)
                result = select_node(vb1.stairs,vb1.select_stairs,cstair,precision);
                vb1.stairs = result.nodes;
                vb1.select_stairs = result.select_nodes;
            end
    end 
end

