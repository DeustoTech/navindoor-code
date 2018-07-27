function y = Measurement_CT04S02(xstate,u)
%MEASUREMENT 
%  u = {matrix [mx2] of beacons positions ; baro; Magne}
%  x = matrix [nx1], [x,y,vx,vy]  
    
    % states vars  
    x  = xstate{1};
    y  = xstate{2};
    vx = xstate{3};
    vy = xstate{4};
    n  = xstate{5};
    % additional knowlegde    
    ibuild= u{1};
    iBBS = u{2};
    
    ilevel  = building.levels(n)
    beacons = ilevel.beacons
    
    
    
    RSS_values = 10*log10(sqrt((x - u(:,1)).^2 + (y - u(:,2) ).^2));
    Baro_values = 
    
    
end
