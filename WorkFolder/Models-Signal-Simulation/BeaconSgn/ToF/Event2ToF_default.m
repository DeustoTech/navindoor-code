function ToFvalue = Event2ToF_default(position,ibeacon,params)
%RSS_DEFAULT Summary of this function goes here
%   Detailed explanation goes here
    r = [ position.x position.y position.z ];
    
    distance = norm(ibeacon.r - r);
    
    c = 3e8;
    ToFvalue = distance/c + normrnd(0,1e-10);

end

