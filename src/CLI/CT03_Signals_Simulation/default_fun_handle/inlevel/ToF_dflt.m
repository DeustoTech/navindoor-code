function result = ToF_dflt(ibeacon,index_node,ilevel,itraj,parameters)
    %% Constants 
    c = 3e8;    
    %% Parameters 
    sigma =  parameters{1};
    %% Init
    inode = itraj.nodes(index_node);
    %
    distance = distn(ibeacon,inode);
    result = distance/c + normrnd(0,sigma);

end
