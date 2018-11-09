function unselect(nodes)
%UNSELECT Summary of this function goes here
%   Detailed explanation goes here
    for inode = nodes
       inode.select = false; 
    end
end

