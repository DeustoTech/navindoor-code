function out = line(walls,varargin)
% description: Draw the list of walls in currently axes
% autor: JesusO
% MandatoryInputs:   
%   walls: 
%    description: List of nodes
%    class: wall
%    dimension: [1xN]
    p = inputParser;
    addRequired(p,'walls')
    
    i = 0;
    out = gobjects(1,length(walls));
    for iwall = walls
       i = i + 1;
       mt = vec2mat([iwall.nodes.r],3);
       if iwall.select
            out(i) = line(mt(:,1),mt(:,2),varargin{:},'LineStyle','--');
       else 
            out(i) =line(mt(:,1),mt(:,2),varargin{:},'LineStyle','-');
       end
    end
end

