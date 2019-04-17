function animation(iGroundTruth,varargin)
%ANIMATION Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'iGroundTruth')
    
    addOptional(p,'axes',[])
    addOptional(p,'map',[])
    
    addOptional(p,'XLim',[])
    addOptional(p,'YLim',[])
    addOptional(p,'last',false)
    
    addOptional(p,'xx',1.0)
    
    parse(p,iGroundTruth,varargin{:})
    
    ax = p.Results.axes;
    xx = p.Results.xx;
    last = p.Results.last;
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
    
    tic;
    tmax = iGroundTruth(1).timeline(end);

   index = 0;
   
   Color_list = {'r','g','b','k','c','y'};
   for iGT = iGroundTruth
        index = index + 1;
        result = step(iGT,0);
        Color = Color_list{index};
        lin(index) = line(result.x,result.y,result.z,'Parent',ax,'Marker','.','Color',Color);
        lin(index).Color = 0.5*([lin(index).Color] + [1 1 1]);
        linpoint(index) = line(result.x,result.y,result.z,'Parent',ax,'Marker','.','Color',0.5*(lin(index).Color + [0 0 0]),'MarkerSize',20);
   end
   legend(ax,lin,{iGroundTruth.label})
   
   if last
        xx = 5*xx;
   end
   
   while true
       t = xx*toc;
       
       index = 0;
       for iGT = iGroundTruth
           index = index + 1;
           result = step(iGT,t);

           lin(index).XData = [ lin(index).XData result.x];
           lin(index).YData = [ lin(index).YData result.y];
           lin(index).ZData = [ lin(index).ZData result.z];

           linpoint(index).XData = result.x;
           linpoint(index).YData = result.y;
           linpoint(index).ZData = result.z;          
       end
      ax.Title.String = ['t = ',num2str(t,'%0.1f'),' seconds  |  ',num2str(t/60,'%0.1f'),' minutes'];

      if ~last
            pause(0.1)
      end
        if t >= tmax||~prod(isvalid(lin))
           return 
        end
    end
end

