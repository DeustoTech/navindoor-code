function dhdx = CT04S01_Measurement_Jacobian(x,u) %h(s)
%MEASUREMENT 
%  u = matrix [mx2] of beacons positions 
%  x = matrix [nx1], [x,y,vx,vy,h]  
%     
    siz = size(u);
    nbeacon = siz(1);
    
    dhdx = zeros(nbeacon,4);
    
    dhdx(:,1) = (10/log(10))*(x(1) - u(:,1))./((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2); 
    dhdx(:,2) = (10/log(10))*(x(2) - u(:,2))./((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2); 
                      
end