function AoAvalue = Event2AoA_default(position,ibeacon,params)
%RSS_DEFAULT Summary of this function goes here
%   Detailed explanation goes here
    v = [ position.vx position.vy position.vz ];
    rb = ibeacon.r;
    
    AoAvalue = acos(dot(v,rb)/(norm(v)*norm(rb)));
    
end

