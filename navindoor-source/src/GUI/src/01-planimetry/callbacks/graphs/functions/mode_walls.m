function mode_walls(vb,cnode,option,precision,index_level)
%INSERT_WALLS Summary of this function goes here
%   Detailed explanation goes here
    
    switch option
        case 'insert'
            if ~isempty(vb.nodes) 
                
                oldnode = vb.nodes([vb.nodes.select] == 1);
                %%
                select(vb.nodes,[cnode.r(1) cnode.r(2)],'precision',precision);  

                if sum([vb.nodes.select])==2
                    new_wall = wall(vb.nodes([vb.nodes.select] == 1));
                    exist_wall = false;
                   for iwall= vb.walls 
                       if iwall == new_wall
                          exist_wall=true; 
                       end
                   end

                   if ~exist_wall
                        new_wall.level = index_level - 1;
                        vb.walls = [ vb.walls new_wall ];                 
                   end
                   oldnode.select = false;
                end
            end
        case 'select'
            if ~isempty(vb.walls)
                select(vb.walls,cnode.r(1:2),'precision',precision);  
            end
    end
    

