function north_arrow(point,xradius,yradius,angle,varargin)
%NORTH_ARROW Summary of this function goes here
%   Detailed explanation goes here
        p = inputParser;
        addRequired(p,'point');
        addRequired(p,'xradius');
        addRequired(p,'yradius');
        addRequired(p,'angle');
        addOptional(p,'axes',gca);
        
        parse(p,point,xradius,yradius,angle,varargin{:})

        axes = p.Results.axes;
        
        theta = 0:0.05:2*pi;
        x = xradius*cos(theta) + point(1);
        y = yradius*sin(theta) + point(2);
        
        quiver(point(1),point(2),0.7*xradius*cos(angle),0.7*yradius*sin(angle), ...
                    'Color','black',  ...
                    'LineWidth',3,    ...
                    'MaxHeadSize',0.8,...
                    'parent',axes )
                
        line(x,y,'LineStyle','-', ...
                 'Color','black', ...
                 'LineWidth',1,   ...
                 'parent',axes )

        x = (1.05)*xradius*cos(theta) + point(1);
        y = (1.05)*yradius*sin(theta) + point(2);
        line(x,y,'LineStyle','-','Color','red','LineWidth',1,'parent',axes) 
        x = (1.1)*xradius*cos(theta) + point(1);
        y = (1.1)*yradius*sin(theta) + point(2);
        line(x,y,'LineStyle','-','Color','black','LineWidth',1,'parent',axes) 

        textxn = point(1) + 1.2*xradius*cos(angle);
        textyn = point(2) + 1.2*yradius*sin(angle);
        text(textxn,textyn,'N','FontSize',20,'Color','blue','FontName','Courier','parent',axes)

end

