function northvalue = Event2Magnetometer_default(position,params)
%EVENT2MAGNETOMETER_DEFAULT Summary of this function goes here
%   Detailed explanation goes here
    v = [ position.vx position.vy position.vz ];
    rb = [0 1 0];
    
    northvalue = acos(dot(v,rb)/(norm(v)*norm(rb)));
    
end

