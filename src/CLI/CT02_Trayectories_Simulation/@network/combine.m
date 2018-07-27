function net = combine(net1,net2)
    step = min([net1.maxstep net2.maxstep]);
    net = network(step);
    net.vertexs = [net1.vertexs net2.vertexs(1:end-1)];
    net.branchs = [net1.branchs net2.branchs]; 
    net.len = net1.len + net2.len - 1 ;

    net.vertexs(net1.len).connections = [  net.vertexs(net1.len).connections ...
                                        net2.vertexs(end).connections + net1.len];

    for index = net1.len + 1 : net.len
        net.vertexs(index).connections = net.vertexs(index).connections + net1.len ;
        for jindex=find(net.vertexs(index).connections > net.len)     
            net.vertexs(index).connections(jindex) = net1.len;
        end
    end
end