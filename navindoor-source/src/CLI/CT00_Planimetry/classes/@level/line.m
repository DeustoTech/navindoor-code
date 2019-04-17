function varargout = line(ilevel,ax,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here
    
    if ~exist('ax','var')
        f = figure;
        ax = axes('Parent',f);
    end
        
    Graphs = gobjects(0);
    
    if ~isempty(ilevel.walls)
        parameters = {'Color','g','LineWidth',1.25,'Parent',ax};
        Graphs = [Graphs,line(ilevel.walls,parameters{:})];
    end

    if ~isempty(ilevel.nodes)
        Graphs = [Graphs,line(ilevel.nodes,'Color','r','Marker','.','MarkerSize',11,'Parent',ax,'LineStyle','none')];
    end

    if ~isempty(ilevel.doors)
        Graphs  = [Graphs,line(ilevel.doors,'Color','c','Marker','s','MarkerSize',10,'Parent',ax,'LineStyle','none')];
    end

    if ~isempty(ilevel.beacons)
        Graphs  = [Graphs,line(ilevel.beacons,'Color','g','Marker','h','MarkerSize',15,'Parent',ax,'LineStyle','none')];
    end
    
    if ~isempty(ilevel.elevators)
        Graphs  = [Graphs,line(ilevel.elevators,'Color','k','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none')];      
    end
   
    if ~isempty(ilevel.stairs)
        Graphs = [Graphs,line(ilevel.stairs,'Color','c','Marker','s','MarkerSize',8,'MarkerFaceColor',[.49 1 .63],'Parent',ax,'LineStyle','none')];
    end

    if nargout > 0
       varargout{1} = Graphs; 
    end
    
end

