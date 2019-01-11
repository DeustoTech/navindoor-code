function animation(iGroundTruth,varargin)
%ANIMATION Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'iGroundTruth')
    
    addOptional(p,'axes',[])
    addOptional(p,'building',[])
    
    addOptional(p,'XLim',[])
    addOptional(p,'YLim',[])

    
    addOptional(p,'xx',1.0)
    
    parse(p,iGroundTruth,varargin{:})
    
    ax = p.Results.axes;
    xx = p.Results.xx;
    XLim = p.Results.XLim;
    YLim = p.Results.YLim;
    ibuilding = p.Results.building;
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
    if ~isempty(ibuilding)
        line3d(ibuilding,'Parent',ax)
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
    
    tic;
    tmax = iGroundTruth(1).timeline(end);

   index = 0;
   
   Color_list = {'r','g','b','k','c','y'};
   for iGT = iGroundTruth
        index = index + 1;
        result = step(iGT,0);
        Color = Color_list{index};
        lin(index) = line(result.x,result.y,result.z,'Parent',ax,'Marker','.','Color',Color); 
   end
   legend(ax,lin,{iGroundTruth.label})
   
   while true
       t = xx*toc;
       
       index = 0;
       for iGT = iGroundTruth
           index = index + 1;
           result = step(iGT,t);

           lin(index).XData = [ lin(index).XData result.x];
           lin(index).YData = [ lin(index).YData result.y];
           lin(index).ZData = [ lin(index).ZData result.z];

       end
      ax.Title.String = ['t = ',num2str(t,'%0.1f'),' seconds  |  ',num2str(t/60,'%0.1f'),' minutes'];

       pause(0.1)
        
       
        if t >= tmax||~prod(isvalid(lin))
           return 
        end
    end
end

