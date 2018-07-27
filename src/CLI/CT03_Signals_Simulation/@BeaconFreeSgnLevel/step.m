function values = step(iBFSLevel,t)
%STEP Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;p.KeepUnmatched = true; % active, if ther are optionals parameters 
    addRequired(p,'iBFSLevel',@BBSLevel_valid);
    addRequired(p,'t',@(t) t_valid(t,iBFSLevel));
    parse(p,iBFSLevel,t)

    index = floor(t/iBFSLevel.dt) + 1;
    values = iBFSLevel.ms(index).values;
end


%% Validations
function boolean = BBSLevel_valid(iBBSLevel)
    boleean = false;
    if ~isa(iBBSLevel,'BBSLevel') 
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
