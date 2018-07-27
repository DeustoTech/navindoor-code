function  plot3(lvl)

    xlm = [0 lvl.dimensions(1)];
    ylm = [0 lvl.dimensions(2)];

    ibuild = build;
    ibuild.levels = zeros(1,lvl.n+1,'level');
    ibuild.levels(end).high = lvl.high;
    
    hold on

    if ~isempty(lvl.nodes)
        plot3(lvl.nodes,'r.','MarkerSize',12,'build',ibuild);
    end
    if ~isempty(lvl.doors)
        plot3(lvl.doors,'cs','MarkerSize',8,'build',ibuild);
    end 
    if ~isempty(lvl.walls)
        plot3(lvl.walls,'Color','blue','MarkerSize',2,'build',ibuild); 
    end
    if ~isempty(lvl.beacons)
        plot3(lvl.beacons,'gh','MarkerSize',8,'DisplayName','Beacons','build',ibuild);
    end
    if ~isempty(lvl.elevators)
        plot3(lvl.elevators,'ks','MarkerSize',8,'build',ibuild);
    end
    if ~isempty(lvl.stairs)
        plot3(lvl.stairs,'rs','MarkerSize',8,'build',ibuild);
    end

    
    xlim(xlm);
    ylim(ylm);
    hold off
end
