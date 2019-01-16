function RSSvalue = Event2RSS_default(position,ibeacon,params)
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
    
   r = [ position.x position.y position.z ];
    
   distance = norm(ibeacon.r - r);
   
   sigma = 0.1;
   RSSvalue = 10*log10(distance)  + normrnd(0,sigma);
   
end

