function result = step(iBBSLevel,t)
%STEP Summary of this function goes here
%   Detailed explanation goes here
    %% Parameters
    p = inputParser;p.KeepUnmatched = true; % active, if ther are optionals parameters 
    addRequired(p,'iBBSLevel',@BBSLevel_valid);
    addRequired(p,'t',@(t) t_valid(t,iBBSLevel));
    parse(p,iBBSLevel,t)

    index = floor(t/iBBSLevel.dt) + 1;
    values = iBBSLevel.ms(index).values;
    index_beacons = iBBSLevel.ms(index).indexs_beacons;
    beacons = iBBSLevel.beacons(index_beacons);
    %% Generate Structure
    result.values = values;
    result.beacons = beacons;
end


%% Validations
function boolean = BBSLevel_valid(iBBSLevel)
    boleean = false;
    if ~isa(iBBSLevel,'BeaconBasedSgnLevel') 
        error('the first parameter must be type BBSLevel')
    else
        boolean = true;
    end
end
function boolean = t_valid(t,BBSLevel)
    boleean = false;
    if ~isnumeric(t)
        error("the t parameter must be numeric")
    elseif t > (BBSLevel.dt * (BBSLevel.len-1))
        error("the t parameter must be lower that max time of the signal")
    else
        boolean = true;
    end
end
