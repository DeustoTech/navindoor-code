function mt_trajectory = ukf_prueba(signals,ibuilding,itraj)
    % description: Implmentacion de UKF en navindoor 
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
        
    initState = step(itraj,0);
    initState = [initState.x initState.y initState.z initState.vx initState.vy];
    
    iestimator = estimator;
    iestimator.signals = signals;
    iestimator.building = ibuilding;
    iestimator.bucle_function       = @UKF_bucle;
    iestimator.initial_function     = @UKF_init;
    iestimator.initial_state        = initState;
    
    dt = 1.0;
    timeline = iestimator.timeline;
    iestimator.timeline = timeline(1):dt:timeline(end);
    compute(iestimator);
    mt_trajectory                   = iestimator.mt_estimation;
    
end

