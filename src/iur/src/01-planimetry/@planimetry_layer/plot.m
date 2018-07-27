function layer = plot(vb,index_level,ax)
   
    delete(ax.Children)
    ilevel = vb(index_level);

    xlim = ax.XLim;
    ylim = ax.YLim;

    if ilevel.showfigure 
         if ~isempty(ilevel.image_map)
            image(ilevel.XLim_image, ilevel.YLim_image,ilevel.image_map)
         end
    end
    set(gca,'YDir','normal')
    if ~isempty(ilevel.walls)
        line(ilevel.walls,'Color','green','LineWidth',3,'Parent',ax);
    end

    if ~isempty(ilevel.select_walls)
        line(ilevel.select_walls,'Color','red','MarkerSize',2,'LineStyle','--','Parent',ax);
    end

    if ~isempty(ilevel.select_nodes)
        line(ilevel.select_nodes,'Color','b','Marker','*','MarkerSize',7.5,'Parent',ax,'LineStyle','none');
    end

    if ~isempty(ilevel.nodes)
        line(ilevel.nodes,'Color','r','Marker','.','MarkerSize',15,'Parent',ax,'LineStyle','none');
    end

    if ~isempty(ilevel.select_doors)
        line(ilevel.select_doors,'Color','c','Marker','*''MarkerSize',10,'Parent',ax,'LineStyle','none');
    end

    if ~isempty(ilevel.doors)
        line(ilevel.doors,'Color','c','Marker','s','MarkerSize',10,'Parent',ax,'LineStyle','none');
    end

    if ~isempty(ilevel.select_beacons)
        line(ilevel.select_beacons,'Color','g','Marker','*','MarkerSize',7.5,'Parent',ax,'LineStyle','none');
    end

    if ~isempty(ilevel.beacons)
        line(ilevel.beacons,'Color','g','Marker','h','MarkerSize',15,'Parent',ax,'LineStyle','none');
    end

    %% elevators
    
    if ~isempty(vb(1).elevators)
        for ielevator = vb(1).elevators
            if ielevator.level == index_level - 1
                line(ielevator,'Color','k','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');
            end
        end
        

    end

    if ~isempty(vb(1).select_elevators)
        index = 0;
        for ielevator = vb(1).select_elevators
            index = index + 1;
            if ielevator.level == index_level - 1
                line(ielevator,'Color','k','Marker','.','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');
            end
        end
    end

    %% stairs
    if ~isempty(vb(1).stairs)
        for istairs = vb(1).stairs
            if istairs.level == index_level - 1
                line(istairs,'Color','c','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');
            end
        end
    end
    
    if ~isempty(vb(1).select_stairs)
        index = 0;
        for istairs = vb(1).select_stairs
            index = index + 1;
            if istairs.level == index_level - 1
                line(istairs,'Color','c','Marker','.','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');
            end
        end
    end   
   %% connections 
   
   for conn=vb(1).connections
      if conn.nodes(1).level == index_level - 1
         line(node(conn.nodes(1).r),'Color','r','Marker','p','MarkerSize',14,'Parent',ax);
      elseif conn.nodes(2).level == index_level - 1
         line(node(conn.nodes(2).r),'Color','r','Marker','p','MarkerSize',14,'Parent',ax);
      end
   end
    
   %% END


    daspect(ax,[1,1,1]);
    ax.XMinorGrid = 'on';
    ax.XLim = xlim;
    ax.YLim = ylim;
    
    layer = ax.Children;
end
