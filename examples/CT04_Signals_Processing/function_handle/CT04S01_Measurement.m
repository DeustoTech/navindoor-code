function y = CT04S01_Measurement(x,u)
%MEASUREMENT 
%  u = matrix [mx2] of beacons positions 
%  x = matrix [nx1], [x,y,vx,vy]  
% 
    y = 10*log10(sqrt((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2));
end
