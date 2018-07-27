function net=netlevel2(level,vi,minstep,potential)
    revisados = [];
    net = network(minstep);
    add(net,vi,0)
    index_father=1;
    while true
        new_vertexs=net.vertexs(index_father:end);
        for ivertex=new_vertexs
            for iter=1:10
                angle = 2*pi*rand;
                x = minstep*cos(angle);
                y = minstep*sin(angle);
                addvertex = vertex([x y]);
                new_vertex = ivertex+addvertex;
                distances = arrayfun(@(x)distn(x,new_vertex),net.vertexs); 
                [distances indexs]=sort(distances);

                cla
                plot(level)
                hold on
                plot(net.branchs)
                plot(new_vertex,'*')
                plot(net.vertexs,'*')
                cla
                if min(distances) >= 0.99*minstep
                    add(net,new_vertex,index_father)
                end
            end
            index_father=index_father+1;   
        end
    end
end
