function mode_doors(vb,cnode,option,precision,index_level)
%MODE_DOORS Summary of this function goes here
%   Detailed explanation goes here
    switch option 
        case 'insert'
            if ~isempty(vb.walls)
                
                unselect(vb.walls)
                result = select(vb.walls,cnode.r,'precision',1.5);
                if ~isempty(result)
                       idoor = door([result.r vb.height ]);
                       vb.walls(result.index).doors = [ vb.walls(result.index).doors idoor];
                       vb.doors = [vb.doors idoor];
                       unselect(vb.walls)

                end

                
            end
        case 'select'
            if ~isempty(vb.doors)
                select(vb.doors,cnode.r,'precision',precision);
            end
    end 
end

