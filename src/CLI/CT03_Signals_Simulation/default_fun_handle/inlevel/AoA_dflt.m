function result = AoA_dflt(ibeacon,index_node,ilevel,itraj,parameters)
    %% Parameters 
    sigma =  parameters{1};
    %% Init
    inode = itraj.nodes(index_node);
    %
    itheta = itraj.angles(index_node);
    R =[ cos(itheta) -sin(itheta) ; sin(itheta) cos(itheta)];
    result = atan_2pi((ibeacon.r-inode.r)*R) + normrnd(0,sigma);

end
