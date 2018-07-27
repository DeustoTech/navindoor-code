function result = normtraj(itraj,step)

    new_linspace = 0:step:itraj.distance;
    new_nodes = zeros(1,length(new_linspace),'vertex');
    index = 0;
    for xnew=new_linspace
        index = index + 1;
        new_nodes(index)=x2vertex(itraj,xnew);
    end

    if ~(itraj.distance == xnew)
        new_nodes = [new_nodes x2vertex(itraj,itraj.distance) ];
    end
    result = traj(new_nodes);
    result.level = itraj.level;
    result.step = step;
end     
