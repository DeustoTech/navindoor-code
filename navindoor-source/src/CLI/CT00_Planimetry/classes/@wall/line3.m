function line3(walls,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'walls')
    
    for iwall = walls
       mt = vec2mat([iwall.nodes.r],3);
       if iwall.select
            line(mt(:,1),mt(:,2),mt(:,3),varargin{:},'LineStyle','--')
       else 
            line(mt(:,1),mt(:,2),mt(:,3),varargin{:},'LineStyle','-')
       end
    end
end

