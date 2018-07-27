function pot=potlevel(level,precision)
    xmax = level.dimensions(1);
    ymax = level.dimensions(2);

    [x,y] = ndgrid(0:precision:xmax,0:precision:ymax);    
    z = x*0;
    pot = potential(x,y,z);
    for iwall=level.walls
       pot = pot + potwall(iwall,precision,xmax,ymax);
    end
end