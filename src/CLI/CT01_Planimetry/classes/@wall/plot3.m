function plot3(walls,varargin)
%% 
    cell_plot = varargin;

    index_build = find(strcmp(varargin,'build') );
    if ~isempty(index_build)
        
        cell_build = varargin(index_build:index_build+1);
        cell_plot(index_build) = [];
        cell_plot(index_build) = [];
            p = inputParser;
            p.KeepUnmatched = true; % active, if ther are optionals parameters 
            addRequired(p,'walls')
            addOptional(p,'build',build)
            parse(p,walls,cell_build{:})

            ibuild = p.Results.build;
    end
    
    
    if ~isempty(index_build)
        heights = [ibuild.levels.high];
        mt_walls=vec2mat([walls(1).nodes.r],2,length(walls));
        plot3(mt_walls(:,1),mt_walls(:,2),[ heights(walls(1).nodes(1).level + 1)  heights(walls(1).nodes(2).level + 1)  ] ,cell_plot{:});
        for nwall=2:length(walls)
            mt_walls=vec2mat([walls(nwall).nodes.r],2,length(walls));
            line(mt_walls(:,1),mt_walls(:,2),[ heights(walls(nwall).nodes(1).level+1) heights(walls(nwall).nodes(2).level +1) ] ,cell_plot{:});
        end
    else    
        mt_walls=vec2mat([walls(1).nodes.r],2,length(walls));
        plot3(mt_walls(:,1),mt_walls(:,2),[ walls(1).nodes(1).level  walls(1).nodes(2).level  ] ,cell_plot{:});
        for nwall=2:length(walls)
            mt_walls=vec2mat([walls(nwall).nodes.r],2,length(walls));
            line(mt_walls(:,1),mt_walls(:,2),[ walls(nwall).nodes(1).level  walls(nwall).nodes(2).level  ] ,cell_plot{:});
        end
    end
    

    grid
end
