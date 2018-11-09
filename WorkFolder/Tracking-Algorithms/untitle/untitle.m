function mt_trajectory = untitle(signals,ibuilding,itraj)
%EKF Summary of this function goes here
%   Detailed explanation goes here
        

    initState = step(itraj,0);
    initState = [initState.x initState.y initState.z initState.vx initState.vy];
    
    
    iestimator = estimator;
    iestimator.signals = signals;
    iestimator.building = ibuilding;
    iestimator.bucle_function       = @EKF_bucle;
    iestimator.initial_function     = @EKF_init;
    iestimator.initial_state        = initState;

    compute(iestimator);
    mt_trajectory                   = iestimator.mt_estimation;
    
end

