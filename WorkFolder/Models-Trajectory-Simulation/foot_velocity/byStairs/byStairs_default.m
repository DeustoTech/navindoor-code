function Events = byStairs_default(isegment,frecuency,varargin)
%BYSTAIRS_DEFAULT Summary of this function goes here
%   Detailed explanation goes here

    pi = isegment.points(1);
    pf = isegment.points(2);

    v  = 2;
    
    iEvent = Event;
    iEvent.r = pi.r;
     
    jEvent = Event;
    jEvent.r = pf.r;

    
    Events = [iEvent jEvent];
    
    
end

