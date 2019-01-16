function line(ilevel,ax,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here
    
    if ~exist('ax','var')
        f = figure;
        ax = axes('Parent',f);
    end
            
    if ~isempty(ilevel.walls)
        line(ilevel.walls,'Color','green','LineWidth',1.25,'Parent',ax);
    end

    if ~isempty(ilevel.nodes)
        line(ilevel.nodes,'Color','r','Marker','.','MarkerSize',11,'Parent',ax,'LineStyle','none');
    end

    if ~isempty(ilevel.doors)
        line(ilevel.doors,'Color','c','Marker','s','MarkerSize',10,'Parent',ax,'LineStyle','none');
    end

    if ~isempty(ilevel.beacons)
        line(ilevel.beacons,'Color','g','Marker','h','MarkerSize',15,'Parent',ax,'LineStyle','none');
    end
    
    if ~isempty(ilevel.elevators)
        line(ilevel.elevators,'Color','k','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');      
    end
   
    if ~isempty(ilevel.stairs)
        line(ilevel.stairs,'Color','c','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');
    end

    %daspect(ax,[1,1,1]);
    ax.XMinorGrid = 'on';
    ax.XLim = [0 ilevel.dimensions(1)];
    ax.YLim = [0 ilevel.dimensions(2)];

    
end

