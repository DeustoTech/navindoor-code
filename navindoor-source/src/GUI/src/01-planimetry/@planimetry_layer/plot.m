function layer = plot(vb,index_level,ax,varargin)
   
    p = inputParser;
    addRequired(p,'vb')
    addRequired(p,'index_level')
    addRequired(p,'ax')
    addOptional(p,'replot',true)
    addOptional(p,'mode',[])
    addOptional(p,'option',[])


    parse(p,vb,index_level,ax,varargin{:})
    
    replot = p.Results.replot;
    
    mode = p.Results.mode;
    option = p.Results.option;

    if replot && (strcmp(option,'insert')||isempty(option))
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
    
    if isempty(mode)||strcmp(mode,'walls')||(strcmp(option,'select') && strcmp(mode,'walls'))
        if ~isempty(ilevel.walls)
            delete(ilevel.layer_graphs.walls)
            ilevel.layer_graphs.walls = line(ilevel.walls,'Color','green','LineWidth',1.5,'Parent',ax);
            if strcmp(option,'insert')
                delete(ilevel.layer_graphs.nodes)
                ilevel.layer_graphs.nodes = line(ilevel.nodes,'Color','r','Marker','.','MarkerSize',14,'Parent',ax,'LineStyle','none');
            end
        end
    end

    if isempty(mode)||strcmp(mode,'nodes')||(strcmp(option,'select') && strcmp(mode,'nodes'))
        if ~isempty(ilevel.nodes)
            delete(ilevel.layer_graphs.nodes)
            ilevel.layer_graphs.nodes = line(ilevel.nodes,'Color','r','Marker','.','MarkerSize',14,'Parent',ax,'LineStyle','none');
        end
    end

    if isempty(mode)||strcmp(mode,'doors')||(strcmp(option,'select') && strcmp(mode,'doors'))
        if ~isempty(ilevel.doors)
            delete(ilevel.layer_graphs.doors)
            ilevel.layer_graphs.doors = line(ilevel.doors,'Color','c','Marker','s','MarkerSize',10,'Parent',ax,'LineStyle','none');
        end
    end
    
    if isempty(mode)||strcmp(mode,'beacons')||(strcmp(option,'select') && strcmp(mode,'beacons'))
        if ~isempty(ilevel.beacons)
            delete(ilevel.layer_graphs.beacons)
            ilevel.layer_graphs.beacons = line(ilevel.beacons,'Color','g','Marker','h','MarkerSize',15,'Parent',ax,'LineStyle','none');
        end
    end
    
    
    if isempty(mode)||strcmp(mode,'elevators')||(strcmp(option,'select') && strcmp(mode,'elevators'))
        if ~isempty(ilevel.elevators)
            delete(ilevel.layer_graphs.elevators)
            ilevel.layer_graphs.elevators = line(ilevel.elevators,'Color','k','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');      
        end
    end
   
    if isempty(mode)||strcmp(mode,'stairs')||(strcmp(option,'select') && strcmp(mode,'stairs'))
        if ~isempty(ilevel.stairs)
            delete(ilevel.layer_graphs.stairs)
            ilevel.layer_graphs.stairs = line(ilevel.stairs,'Color','c','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none');
        end
    end
   

    daspect(ax,[1,1,1]);
    ax.XMinorGrid = 'on';
    
   
    layer = ax.Children;
end
