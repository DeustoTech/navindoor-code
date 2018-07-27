function pot = potwall(obj,precision,xmax,ymax)
    [x,y] = ndgrid(0:precision:xmax,0:precision:ymax);
    z = x*0;

    x1 = obj.nodes(1).r(1);
    y1 = obj.nodes(1).r(2);
    x2 = obj.nodes(2).r(1);
    y2 = obj.nodes(2).r(2);
    
    theta = -atan((y2-y1)/(x2-x1));
    h = obj.width;
    k = 0.25*precision;
    Rx1 = 0;Ry1 = 0;
    Rx2 = (x2-x1).*cos(theta) - (y2-y1).*sin(theta) ;
    Ry2 = (x2-x1).*sin(theta) + (y2-y1).*cos(theta);

    Rx = (x-x1).*cos(theta) - (y-y1).*sin(theta) ;
    Ry = (x-x1).*sin(theta) + (y-y1).*cos(theta) ;
    z = z + (0.5*(tanh(2*(Rx-Rx1-0.2)/k) + tanh(2*(Rx2-Rx+0.2)/k))).*(0.5*(tanh(2*(Ry+0.5*h)/k) + tanh(2*(0.5*h-Ry)/k)));

    if ~isempty(obj.doors)
        for idoor=obj.doors
            dx = idoor.r(1);
            dy = idoor.r(2);  
            Rdy = (x-dx).*cos(theta+0.5*pi) - (y-dy).*sin(theta+0.5*pi) ;
            Rdx = (x-dx).*sin(theta+0.5*pi) + (y-dy).*cos(theta+0.5*pi) ;
            pot_doors = (0.5*(tanh(2*(Rdx+0.5*(idoor.width))/k) + tanh(2*(0.5*(idoor.width)-Rdx)/k))).*(0.5*(tanh(2*(Rdy+0.5*h+4*k)/k) + tanh(2*(0.5*h-Rdy+4*k)/k)));

            z =z-2.*pot_doors;
        end 

    end

    pot = potential(x,y,z);
end