function Events = byStairs_default(isegment,frecuency,varargin)
    % description: Function 
    % MandatoryInputs:   
    %       isegment: 
    %           description: the Segment is the section of trajectory that will be simulate. This object 
    %                   has a property called type. This property will be equal to Floor. This indicate 
    %                   that the simulation of trajectory is in floor.
    %                   
    %           class: segment
    %           dimension: [1xN]
    %       frecuency: 
    %           description: interval of time of mesurements
    %           class: double
    %           dimension: [1x1]       
    % OptionalInputs:
    %       length_step:
    %           description: Length step of pedertrian
    %           class: double
    %           dimension: [1x1]
    % Outputs:
    %       Events:
    %           description: List of object Events. Event is a MATLAB class that 
    %                        represents the point [x,y,z,t]. The trajectory is define by a list 
    %                        of events.
    %           class: Events
    %           dimension: [1x1]    

    pi = isegment.points(1);
    pf = isegment.points(2);

    v  = 2;
    
    iEvent = Event;
    iEvent.r = pi.r;
     
    jEvent = Event;
    jEvent.r = pf.r;

    
    Events = [iEvent jEvent];
    
    
end

