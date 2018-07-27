function line(ilevel,varargin)

    xlm = [0 ilevel.dimensions(1)];
    ylm = [0 ilevel.dimensions(2)];
    
    rx = ilevel.dimensions(1)*0.01;
    north_arrow([0.95*xlm(2) 0.95*ylm(2)],rx,rx,ilevel.north)
    
    if ~isempty(ilevel.nodes)
        line(ilevel.nodes,'Marker','.','MarkerSize',10,'Color','r','LineStyle','none',varargin{:});
    end
    if ~isempty(ilevel.doors)
        line(ilevel.doors,'Marker','s','MarkerSize',6,'Color','c','LineStyle','none',varargin{:});
    end 
    if ~isempty(ilevel.walls)
        line(ilevel.walls,'MarkerSize',2,'Color','b',varargin{:});    
    end
    if ~isempty(ilevel.beacons)
        line(ilevel.beacons,'Marker','h','MarkerSize',8,'DisplayName','Beacons','Color','g','LineStyle','none',varargin{:});
    end
    if ~isempty(ilevel.elevators)
        line(ilevel.elevators,'Marker','s','MarkerSize',8,'Color','k','LineStyle','none',varargin{:});
    end
    if ~isempty(ilevel.stairs)
        line(ilevel.stairs,'Marker','h','MarkerSize',8,'Color','k','LineStyle','none',varargin{:});
    end

    xlim(xlm);
    ylim(ylm);



end       
