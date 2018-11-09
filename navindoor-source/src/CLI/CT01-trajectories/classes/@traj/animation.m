function animation(itraj,varargin)
%ANIMATION Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'itraj')
    
    addOptional(p,'axes',[])
    
    addOptional(p,'XLim',[])
    addOptional(p,'YLim',[])
    
    addOptional(p,'xx',1.0)
    
    parse(p,itraj,varargin{:})
    
    ax = p.Results.axes;
    xx = p.Results.xx;
    XLim = p.Results.XLim;
    YLim = p.Results.YLim;

    if isempty(ax)
        ax  = axes();
    end
    if ~isempty(XLim)
        ax.XLim = XLim;
    end
    if ~isempty(YLim)
        ax.YLim = YLim;
    end    
    
    tic;
    tmax = itraj.GroundTruths.Ref.timeline(end);
    
   result = step(itraj.GroundTruths.Ref,0);
   lin = line(result.x,result.y,'Parent',ax,'Marker','.','Color','black'); 

    while true
       t = xx*toc;
       result = step(itraj.GroundTruths.Ref,t);
        
       lin.XData = [ lin.XData result.x];
       lin.YData = [ lin.YData result.y];
       ax.Title.String = ['t = ',num2str(t,'%0.2f'),' s'];
       pause(0.1)
        
       
        if t >= tmax||~isvalid(lin) 
           return 
        end
    end
end

