function nodes = DeleteSelect(nodes)
%DELETE Summary of this function goes here
%   Detailed explanation goes here

    num_eliminados = 0;
    len = length(nodes);
    for index = 1:len 
        inode = nodes(index - num_eliminados);
        if isvalid(inode)
            if inode.select
               delete(inode) 
               nodes(index - num_eliminados) = [];
              num_eliminados = num_eliminados + 1;
            end
        else
           nodes(index - num_eliminados) = [];
           num_eliminados = num_eliminados + 1;
        end
    end 
    
end

