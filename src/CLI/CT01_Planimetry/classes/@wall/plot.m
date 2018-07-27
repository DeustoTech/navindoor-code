function plot(walls,varargin) 
    %% 
    mt_walls=vec2mat([walls(1).nodes.r],2,length(walls));
    plot(mt_walls(:,1),mt_walls(:,2),varargin{:});
    for nwall=2:length(walls)
        mt_walls=vec2mat([walls(nwall).nodes.r],2,length(walls));
        line(mt_walls(:,1),mt_walls(:,2),varargin{:});
    end
end  