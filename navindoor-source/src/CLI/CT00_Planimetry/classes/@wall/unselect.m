function unselect(walls)
%UNSELECT Summary of this function goes here
%   Detailed explanation goes here
    for iwall = walls
        iwall.select = false;
    end
end

