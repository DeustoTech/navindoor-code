function layer = plot(vb,index_level,ax,varargin)
   
    p = inputParser;
    addRequired(p,'vb')
    addRequired(p,'index_level')
    addRequired(p,'ax')
    addOptional(p,'replot',true)

    parse(p,vb,index_level,ax,varargin{:})
    
    replot = p.Results.replot;
    if replot
        delete(ax.Children)
    end
    ilevel = vb(index_level);

    xlim = ax.XLim;
    ylim = ax.YLim;

    if ilevel.showfigure 
         if ~isempty(ilevel.image_map)
            ylim1 = ilevel.YLim_image(2);
            ylim2 = ilevel.YLim_image(1);
            YLim = [ylim1 ylim2];
            hold(ax,'on')
            image(ilevel.XLim_image, YLim ,ilevel.image_map,'Parent',ax)
            hold(ax,'off')
         end
    end
    set(ax,'YDir','normal')
    
    
    if ~isempty(ilevel.walls)
        line(ilevel.walls,'Color','green','LineWidth',3,'Parent',ax);
    end

    if ~isempty(ilevel.nodes)
        line(ilevel.nodes,'Color','r','Marker','.','MarkerSize',15,'Parent',ax,'LineStyle','none');
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

   

    daspect(ax,[1,1,1]);
    ax.XMinorGrid = 'on';
    
    
%     autozoom  se ha subordinado a la funcion update_planimetry_layer
%      if rezoom
%          ax.XLim = ilevel.XLim;
%          ax.YLim = ilevel.YLim;
%      end
     
    layer = ax.Children;
end
