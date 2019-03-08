classdef picture < handle
    %PICTURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Image
        Angle = 0;
        Parent
        CData
        imrect
    end
    
    methods
        function obj = picture(varargin)
            %PICTURE Construct an instance of this class
            %   Detailed explanation goes here
            p = inputParser;
            
            addOptional(p,'pathpicture','cameraman.tif')
            addOptional(p,'Parent',[])
            addOptional(p,'XLim',[])
            addOptional(p,'YLim',[])
            parse(p,varargin{:})
            
            pathpicture = p.Results.pathpicture;
            obj.Parent = p.Results.Parent;
            XLim = p.Results.XLim;
            YLim = p.Results.YLim;
 
                
            if isempty(obj.Parent)
               obj.Parent = axes; 
               line(1:10,1:10,'Parent',obj.Parent)
            end
            
                       
            if isempty(YLim)
                YLim = obj.Parent.YLim;
            end
                       
            if isempty(XLim)
                XLim = obj.Parent.XLim;
            end
                        
            obj.CData=flipud(imread(pathpicture));
            beforeNextPlot = obj.Parent.NextPlot;
            obj.Parent.NextPlot = 'add';
   
            obj.Image = image(obj.CData,'Parent',obj.Parent,'XData',XLim,'YData',YLim);
            obj.Parent.Children = [obj.Parent.Children(2:end) ;obj.Parent.Children(1)];
            obj.Parent.NextPlot = beforeNextPlot;

            XData = obj.Image.XData;
            YData = obj.Image.YData;
            
            
            obj.imrect = imrect(obj.Parent,[XData(1) YData(1) XData(2)-XData(1) YData(2)-YData(1)]) ;
            
            Childrens = get(obj.imrect,'Children');
            for ichild = Childrens
               set(ichild,'PickableParts','visible')
            end
            
            addNewPositionCallback(obj.imrect,@(pos)ResizeFigureFromImrect(pos,obj))

            
        end
        
    end
end

