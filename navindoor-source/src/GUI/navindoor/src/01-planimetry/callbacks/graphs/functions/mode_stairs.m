function mode_stairs(vb1,cnode,option,precision,index_level)
    cstair = stairs;
    cstair.r = cnode.r;
    switch option 
        case 'insert'
            vb1.stairs = [vb1.stairs cstair];
        case 'select'
            if ~isempty(vb1.stairs)
                select(vb1.stairs,cnode.r,'precision',precision);
            end
    end 
end

