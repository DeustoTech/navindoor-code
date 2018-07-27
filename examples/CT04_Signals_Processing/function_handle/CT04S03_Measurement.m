function y = CT04S03_Measurement(x,u) %h(s)
%MEASUREMENT 
%  u = matrix [mx2] of beacons positions 
%  x = matrix [nx1], [x,y,vx,vy]  
%  
    c = 3e8;

    [nbeacon,~] = size(u);
    y = zeros(2*nbeacon,1);
    y(1:nbeacon)     = 10*log10(sqrt((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2));
    y(nbeacon+1:end) = ((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2)/c;
    
end