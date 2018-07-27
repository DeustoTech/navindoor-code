function  plot(lvl,varargin)

    xlm = [0 lvl.dimensions(1)];
    ylm = [0 lvl.dimensions(2)];

    if exist('plano','var')
        [image_map3,~] = imread(plano);
        image(xlm, ylm,image_map3); 
        set(gca,'YDir','normal')
    end

    hold on


    if ~isempty(lvl.nodes)
        plot(lvl.nodes,'r.','MarkerSize',10,varargin{:});
    end
    if ~isempty(lvl.doors)
        plot(lvl.doors,'cs','MarkerSize',6,varargin{:});
    end 
    if ~isempty(lvl.walls)
        plot(lvl.walls,'Color','blue','MarkerSize',2,varargin{:});    
    end
    if ~isempty(lvl.beacons)
        plot(lvl.beacons,'gh','MarkerSize',8,varargin{:});
    end
    if ~isempty(lvl.elevators)
        plot(lvl.elevators,'ks','MarkerSize',8,varargin{:});
    end
    if ~isempty(lvl.stairs)
        plot(lvl.stairs,'kh','MarkerSize',8,varargin{:});
    end

    xlim(xlm);
    ylim(ylm);

    rx = lvl.dimensions(1)*0.01;
    xlabel('x [m]');
    ylabel('y [m]');

    
    %north_arrow(rx,rx,lvl.north,'axes',gca)

    hold off
end       
