function tfinal=trajnodes(net,level,nodes)
    lennodes = length(nodes);
    trajs=zeros(1,lennodes-1,'traj');
    tfinal = zeros(1,1,'traj');
    for index=1:lennodes-1 
        trajs(index) = traj_network(net,nodes(index),nodes(index+1));
        lenreduce = trajs(index).len+ 2*round(trajs(index).len*rand);
        trajs(index) = reducepath(trajs(index),lenreduce,level);
        trajs(index) = smoothpath(trajs(index));
        trajs(index) = inverse(trajs(index));
        trajs(index).nodes(end) = [];
        tfinal = tfinal + trajs(index);

    end
end