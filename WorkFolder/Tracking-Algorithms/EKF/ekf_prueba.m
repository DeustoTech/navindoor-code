function mt_trajectory = ekf_prueba(signals,ibuilding,itraj)
    % description: Implmentacion de EKF en navindoor  
    % MandatoryInputs:   
    %       signals: 
    %           description: Celda donde se encuentran las senales. Estas pueden ser BeaconSgn o FreeSgn
    %           class: cell
    %           dimension: [1xN]
    %       ibuilding: 
    %           description: Contiene toda la informacion de la planimetria donde transcurre la trajectoria 
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
    iestimator.bucle_function       = @EKF_bucle;
    iestimator.initial_function     = @EKF_init;
    iestimator.initial_state        = initState;
    
    dt = 1.0;
    timeline = iestimator.timeline;
    iestimator.timeline = timeline(1):dt:timeline(end);
    compute(iestimator);
    mt_trajectory                   = iestimator.mt_estimation;
    
end

