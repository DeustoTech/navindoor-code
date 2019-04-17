function animation(itraj,varargin)
%ANIMATION Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'itraj')
    
    addOptional(p,'axes',[])
    addOptional(p,'map',[])
    
    addOptional(p,'XLim',[])
    addOptional(p,'YLim',[])

    
    addOptional(p,'xx',1.0)
    
    parse(p,itraj,varargin{:})
    
    ax = p.Results.axes;
    xx = p.Results.xx;
    XLim = p.Results.XLim;
    YLim = p.Results.YLim;
    imap =  p.Results.map;
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
        plot(imap.buildings,ax,'nonodes',true)
    end
    
    ax.XGrid = 'on';ax.YGrid = 'on';ax.ZGrid = 'on';
    ax.View = [45,35];
    
    maxax = max([itraj.GroundTruths.Ref.Events.z]);
    minax = min([itraj.GroundTruths.Ref.Events.z]);
    
    if maxax ~= minax
        ax.ZLim = [minax maxax];
    end
    tic;
    tmax = itraj.GroundTruths.Ref.timeline(end);
    
   result = step(itraj.GroundTruths.Ref,0);

   
   lin = line(result.x,result.y,result.z,'Parent',ax,'Marker','.','Color',[0.5 0.5 0.5]); 

   pointred = line(result.x,result.y,result.z,'Parent',ax,'Marker','.','Color','red'); 
    while true
       t = xx*toc;
       result = step(itraj.GroundTruths.Ref,t);
        
       
       delete(pointred)
       pointred = line(result.x,result.y,result.z,'Parent',ax,'Marker','.','Color','red','MarkerSize',25); 

       lin.XData = [ lin.XData result.x];
       lin.YData = [ lin.YData result.y];
       lin.ZData = [ lin.ZData result.z];

       ax.Title.String = ['t = ',num2str(t,'%0.1f'),' seconds  |  ',num2str(t/60,'%0.1f'),' minutes'];
       pause(0.1)
        
       
        if t >= tmax||~isvalid(lin) 
           return 
        end
    end
end

