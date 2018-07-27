function plot3(nodes,varargin)
    %% plot list of nodes 
    % validations 
        
    
    index_build = find(strcmp(varargin,'build') );
    cell_plot = varargin;

    if ~isempty(index_build)
        
        cell_build = varargin(index_build:index_build+1);
        cell_plot(index_build) = [];
        cell_plot(index_build) = [];
            p = inputParser;
            p.KeepUnmatched = true; % active, if ther are optionals parameters 
            addRequired(p,'nodes')
            addOptional(p,'build',build)
            parse(p,nodes,cell_build{:})

            ibuild = p.Results.build;
    end
    

    
    
    mt_nodes = vec2mat([nodes.r],2);

    dx = mt_nodes(:,1);
    dy = mt_nodes(:,2);
    
    if ~isempty(index_build)
        heights = [ibuild.levels.high];
        plot3(dx,dy,heights([nodes.level]+1),cell_plot{:});
    else    
        plot3(dx,dy,[nodes.level],cell_plot{:});
    end
end      

