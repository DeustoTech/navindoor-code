function varargout = plot(imap,varargin)
% Plot map objects 

    p = inputParser;
    addRequired(p,'imap')
    addOptional(p,'Parent',[])
    addOptional(p,'Indexs',[])
    addOptional(p,'doors',false)

    parse(p,imap,varargin{:})
    Parent = p.Results.Parent;
    Indexs = p.Results.Indexs;
    doors  = p.Results.doors;
    %% Pre Proces
    if isempty(Parent)
       Parent = gca; 
    end
    %% Init
    
    index = 0;
    for ibuildings = imap.buildings
        border = ibuildings.border.position;
        border = [border;border(1,:)];
        
        nExtWalls = length(ibuildings.border.walls);
        for ilevel = ibuildings.levels
           iwalls = ilevel.walls(1:nExtWalls);
           idoors = [iwalls.doors];
           %
           if ~isempty(idoors) && doors
               index = index + 1;
               rdoors = vec2mat([idoors.r],3);
               graphs(index) = line(rdoors(:,1),rdoors(:,2),'Parent',Parent,'Marker','s','Color','k','LineStyle','none','MarkerSize',15); 
           end
        end
        index = index + 1;

        graphs(index) = line(border(:,1),border(:,2),'Parent',Parent,'LineStyle','--');
        
        index = index + 1;

        graphs(index) = patch(border(:,1),border(:,2),[1 1 0.8],'Parent',Parent,'LineStyle','--','PickableParts','none');        
    end
    
    if ~isempty(Indexs)
        IndexBuilding   = Indexs(1);
        IndexLevel      = Indexs(2);

        ilevel = imap.buildings(IndexBuilding).levels(IndexLevel);

        graphs_level = line(ilevel,Parent);
        graphs = [graphs,graphs_level];
    end
    
    if nargout > 0
        varargout{1} = graphs;
    end 
end

