function tfinal=trajnodes(potential,level,nodes)
    lennodes = length(nodes);
    trajs=zeros(1,lennodes-1,'traj');
    tfinal = zeros(1,1,'traj');
    for index=1:lennodes-1 
        trajs(index) = traj_AStar(potential,nodes(index),nodes(index+1));
        lenreduce = trajs(index).len;
        trajs(index) = reducepath(trajs(index),lenreduce,level);
        trajs(index) = smoothpath(trajs(index));
        trajs(index).nodes(end) = [];
        tfinal = tfinal + trajs(index);
    end
end
