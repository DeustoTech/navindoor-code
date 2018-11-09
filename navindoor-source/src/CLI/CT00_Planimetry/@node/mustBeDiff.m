function mustBeDiff(nodes)
%MUSTBEDIFF Summary of this function goes here
%   Detailed explanation goes here

    mat         = vec2mat([nodes.r],3);
    mat_unique  = unique(mat,'rows');
    
    if  (length(mat(:,1)) ~= length(mat_unique(:,1)))
        error('The nodes must be different')
    end
end

