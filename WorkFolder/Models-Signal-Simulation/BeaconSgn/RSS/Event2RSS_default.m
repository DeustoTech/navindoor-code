function RSSvalue = Event2RSS_default(position,ibeacon,params)
%RSS_DEFAULT Summary of this function goes here
%   Detailed explanation goes here
   r = [ position.x position.y position.z ];
    
   distance = norm(ibeacon.r - r);
   
   sigma = 0.1;
   RSSvalue = 10*log10(distance)  + normrnd(0,sigma);
end

