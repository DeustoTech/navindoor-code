function result =select_node(nodes,select_nodes,cnode,precision)

    if isempty(nodes) && isempty(select_nodes)
        result.nodes = nodes;
        result.select_nodes = select_nodes;
        return
    end 
    all_nodes = [nodes select_nodes];
    distances = arrayfun(@(x) distn(x,cnode),all_nodes);

    [sort_distances,sort_index_nodes] = sort(distances);

    min_distance = sort_distances(1);          
    index = sort_index_nodes(1); 

    if min_distance < precision        
        if index <= length(nodes)
            select_nodes = [ select_nodes nodes(index)];
            nodes(index) = [];
        else
            index = index-length(nodes);
            nodes = [nodes select_nodes(index)];
            select_nodes(index)=[];
        end  
    end
    result.nodes = nodes;
    result.select_nodes = select_nodes;
    result.sort_index_nodes = sort_index_nodes;
    result.sort_distances = sort_distances;
    result.distance =  min_distance;
    result.index = index;
end