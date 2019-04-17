function result = default_values()
%DEFAULT_VALUES of all framework

%% traj

result.traj.FootFrecuency = 25;

result.traj.byFloorFcn              = @byFloor_default;
result.traj.byFloorParams         = {};

result.traj.byStairsFcn             = @byStairs_default;
result.traj.byStairsParams        = {};

result.traj.byElevatorsFcn          = @byElevators_default;
result.traj.byElevatorsParams       = {};

result.traj.foot2RefFcn             = @foot2Ref_default;
result.traj.foot2RefParams          = {'RefFrecuency',2};       % Reference Groundtruth 2Hz

%% Free Sgn defaults

% =================================================================================
result.FreeSgn.Event2msFcn.Magnetometer     = @Event2Magnetometer_default;
result.FreeSgn.Event2msParams.Magnetometer  =  {1.0};
result.FreeSgn.frecuency.Magnetometer       = 10;
result.FreeSgn.dimension.Magnetometer = 1 ;
result.FreeSgn.GroundTruth.Magnetometer     = 'Ref';
% =================================================================================
result.FreeSgn.Event2msFcn.Barometer        = @Event2Barometer_default;
result.FreeSgn.Event2msParams.Barometer     =  {1.0};
result.FreeSgn.frecuency.Barometer          = 10;
result.FreeSgn.dimension.Barometer = 1 ;
result.FreeSgn.GroundTruth.Barometer     = 'Ref';
% =================================================================================
result.FreeSgn.Event2msFcn.InertialFoot     = @Event2InertialFoot_default;
result.FreeSgn.Event2msParams.InertialFoot  =  {1.0};
result.FreeSgn.frecuency.InertialFoot       = 50;
result.FreeSgn.dimension.InertialFoot = 6 ; % [aceleration and gyro]
result.FreeSgn.GroundTruth.InertialFoot     = 'foot';
% ===============================================================================
result.FreeSgn.Event2msFcn.InertialCoM      = @Event2InertialCoM_default;
result.FreeSgn.Event2msParams.InertialCoM   =  {1.0};
result.FreeSgn.frecuency.InertialCoM       = 10;
result.FreeSgn.dimension.InertialCoM = 6 ;% [aceleration and gyro]
result.FreeSgn.GroundTruth.InertialCoM     = 'CoM';
% =================================================================================

%% Beacons Sgn defaults

result.BeaconSgn.Event2msFcn.ToF      = @Event2ToF_default;
result.BeaconSgn.Event2msParams.ToF   =  {1.0};

result.BeaconSgn.Event2msFcn.AoA      = @Event2AoA_default;
result.BeaconSgn.Event2msParams.AoA   =  {1.0};

result.BeaconSgn.Event2msFcn.RSS      = @Event2RSS_default;
result.BeaconSgn.Event2msParams.RSS   =  {1.0};

end

