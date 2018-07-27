function tryexpand(net,potential,ivertex)
    select = [];
    precision = net.maxstep;

    result = select_node(net.vertexs(1:net.len),select,ivertex,precision);
    if ~isempty(result.select_nodes) 
        vertex_father = result.select_nodes;
        index_father = result.index;
        itraj = traj([vertex_father ivertex]);
        if trajoflevelpotential(itraj,potential)
            add(net,ivertex,index_father);  
        end
    end

end