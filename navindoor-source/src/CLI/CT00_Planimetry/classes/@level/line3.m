function line3(ilevel,ax,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here
    
    p = inputParser;
    addRequired(p,'ilevel')
    addRequired(p,'ax')
    addOptional(p,'nonodes',false)

    parse(p,ilevel,ax,varargin{:})
    
    nonodes = p.Results.nonodes;
    
    if ~isempty(ilevel.walls)
        line3(ilevel.walls,'Color',[0.6 1 0.6]','LineWidth',1.5,'Parent',ax);
    end
    
    
    if ~isempty(ilevel.nodes)
        if ~nonodes
            line3(ilevel.nodes,'Color','r','Marker','.','MarkerSize',12,'Parent',ax,'LineStyle','none');
        end
    end

    if ~isempty(ilevel.doors)
        if ~nonodes
        line3(ilevel.doors,'Color','c','Marker','s','MarkerSize',10,'Parent',ax,'LineStyle','none');
        end
    end

    if ~isempty(ilevel.beacons)
        if ~nonodes
        line3(ilevel.beacons,'Color','g','Marker','h','MarkerSize',15,'Parent',ax,'LineStyle','none');
        end
    end
    
    if ~isempty(ilevel.elevators)
        if ~nonodes
        line3(ilevel.elevators,'Color','k','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');      
        end
    end
   
    if ~isempty(ilevel.stairs)
        if ~nonodes
        line3(ilevel.stairs,'Color','c','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');
        end
    end

    %daspect(ax,[1,1,1]);
    ax.XMinorGrid = 'on';
    %ax.XLim = [0 ilevel.dimensions(1)];
    %ax.YLim = [0 ilevel.dimensions(2)];

    
end

