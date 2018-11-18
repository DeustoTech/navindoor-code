function mode_nodes(vb,cnode,option,precision)
%INSERT_NODES Summary of this function goes here
%   Detailed explanation goes here

    switch option 
        case 'insert'
                %% Podemos dividir una pared
            if ~isempty(vb.walls)
                unselect(vb.walls)
                result = select(vb.walls,cnode.r,'precision',0.2);
                if ~isempty(result)
                       r = [result.r ,vb.height];
                       n12 = node(r);
                       n1 = vb.walls(result.index).nodes(1);
                       n2 = vb.walls(result.index).nodes(2);
                       %
                       w1 = wall([n1 n12]);
                       w2 = wall([n2 n12]);
                       
                       vb.nodes = [ vb.nodes n12];
                       vb.walls = [ vb.walls w1 w2 ];
                       
                       delete(vb.walls(result.index))
                       vb.walls = RemoveHandle(vb.walls);
                       return
                end
                
            end
            
            vb.nodes = [vb.nodes cnode];
                
        case 'select'
            if ~isempty(vb.nodes)
                select(vb.nodes,cnode.r,'precision',precision);
            end
    end
    
    
end

