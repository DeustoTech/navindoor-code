function last(iGroundTruth,varargin)
%ANIMATION Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'iGroundTruth')
    
    addOptional(p,'axes',[])
    addOptional(p,'map',[])
    
    addOptional(p,'XLim',[])
    addOptional(p,'YLim',[])
    
    
    parse(p,iGroundTruth,varargin{:})
    
    ax = p.Results.axes;
    XLim = p.Results.XLim;
    YLim = p.Results.YLim;
    imap = p.Results.map;
    %%
    
    if isempty(ax)
        f = figure;
        ax  = axes('Parent',f);
    end
    if ~isempty(XLim)
        ax.XLim = XLim;
    end
    if ~isempty(YLim)
        ax.YLim = YLim;
    end    
    if ~isempty(imap)
        plot(imap,'Parent',ax)
    end
    
    ax.XGrid = 'on';ax.YGrid = 'on';ax.ZGrid = 'on';
    ax.View = [45,35];
    
    index = 0;
    maxax = zeros(length(iGroundTruth),1);
    minax = zeros(length(iGroundTruth),1);
    for iGT = iGroundTruth
        index = index + 1;
        maxax(index) = max([iGT.Events.z]);
        minax(index) = min([iGT.Events.z]);
    end
    
    maxax = max(maxax);
    minax = min(minax);
    ax.ZLim = [minax maxax+0.01];
    

   index = 0;
   
   Color_list = {'r','g','b','k','c','y'};
   for iGT = iGroundTruth
        index = index + 1;
        result = step(iGT,iGT.timeline);
        Color = Color_list{index};
        lin(index) = line([result.x],[result.y],[result.z],'Parent',ax,'Marker','.','Color',Color); 
   end
   legend(ax,lin,{iGroundTruth.label})
    %rotate3d(ax)

end

