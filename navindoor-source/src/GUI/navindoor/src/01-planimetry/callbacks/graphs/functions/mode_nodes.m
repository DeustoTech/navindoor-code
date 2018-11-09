function mode_nodes(vb,cnode,option,precision)
%INSERT_NODES Summary of this function goes here
%   Detailed explanation goes here

    switch option 
        case 'insert'
                vb.nodes = [vb.nodes cnode];
        case 'select'
            if ~isempty(vb.nodes)
                select(vb.nodes,cnode.r,'precision',precision);
            end
    end
    
    
end

