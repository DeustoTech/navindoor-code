function inode = FindByID(nodes,id)
%FINDBYID Summary of this function goes here
%   Detailed explanation goes here
index = find(contains({nodes.id},id));
inode = nodes(index);
end

