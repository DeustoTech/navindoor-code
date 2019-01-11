function line3(ilevel,ax,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here
    
    
    if ~isempty(ilevel.walls)
        line3(ilevel.walls,'Color','green','LineWidth',3,'Parent',ax);
    end

    if ~isempty(ilevel.nodes)
        line3(ilevel.nodes,'Color','r','Marker','.','MarkerSize',15,'Parent',ax,'LineStyle','none');
    end

    if ~isempty(ilevel.doors)
        line3(ilevel.doors,'Color','c','Marker','s','MarkerSize',10,'Parent',ax,'LineStyle','none');
    end

    if ~isempty(ilevel.beacons)
        line3(ilevel.beacons,'Color','g','Marker','h','MarkerSize',15,'Parent',ax,'LineStyle','none');
    end
    
    if ~isempty(ilevel.elevators)
        line3(ilevel.elevators,'Color','k','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');      
    end
   
    if ~isempty(ilevel.stairs)
        line3(ilevel.stairs,'Color','c','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');
    end

    %daspect(ax,[1,1,1]);
    ax.XMinorGrid = 'on';
    ax.XLim = [0 ilevel.dimensions(1)];
    ax.YLim = [0 ilevel.dimensions(2)];

    
end

