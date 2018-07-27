function result = RSS_dflt(ibeacon,index_node,ilevel,itraj,parameters)

    %% Parameters 
    sigma =  parameters{1};
    %% Init
    inode = itraj.nodes(index_node);
    distance = distn(ibeacon,inode);
    result = 10*log10(distance) + normrnd(0,sigma);

end
