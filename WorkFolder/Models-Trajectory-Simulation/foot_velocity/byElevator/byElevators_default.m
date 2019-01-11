function Events = byElevators_default(isegment,frecuency,varargin)
%BYELEVATORS_DEFAULT Summary of this function goes here
%   Detailed explanation goes here

    pi = isegment.points(1);
    pf = isegment.points(2);

    v  = 2;
    
    iEvent = Event;
    iEvent.r = pi.r;
    
    jEvent = Event;
    jEvent.r = pf.r;
    
    jEvent.ax = 0;
    jEvent.ay = 0;
    jEvent.az = 0;

    
    Events = [iEvent jEvent];
    
end

