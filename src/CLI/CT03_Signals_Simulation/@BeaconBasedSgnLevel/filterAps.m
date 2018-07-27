function iBBSLevels = filterAps(iBBSLevels,inequality,extreme_value)
%FILTERAPS 
    % Parameters
    %   - iBBSLevels: List of BBSLevels object. The first element is used
    %   as order 
    %   - NumMaxAps: Integer number that is used to filter signals
    %   - direction: Parameter of sort function. 
    
    %% Parameters Asignment

    pint = inputParser;pint.KeepUnmatched = true; % active, if ther are optionals parameters 
   
    % Required Parameters 
    addRequired(pint,'iBBSLevels',@BBSLevel_valid);
    addRequired(pint,'inequality',@direction_valid);
    addRequired(pint,'extreme_value',@extreme_values_valid);

    parse(pint,iBBSLevels,inequality,extreme_value)
    
   
    %
    %% Init 
    for index = 1:iBBSLevels(1).len
    % for each ms_node
    
        %% Compute their boolean index 
        values = iBBSLevels(1).ms(index).values;
    
        if strcmp(inequality,'>')
            bolean_index = values > extreme_value;
        elseif strcmp(inequality,'<')
            bolean_index = values < extreme_value;
        end
        %%     
        iBBSLevels(1).ms(index).values         = iBBSLevels(1).ms(index).values(bolean_index);
        iBBSLevels(1).ms(index).indexs_beacons = iBBSLevels(1).ms(index).indexs_beacons(bolean_index);
        
        % Other BBS in iBBSLevels follow  first element  
        if length(iBBSLevels) > 1
            for other_iBBSLvls = 2:length(iBBSLevels)
                iBBSLevels(other_iBBSLvls).ms(index).values         = iBBSLevels(other_iBBSLvls).ms(index).values(bolean_index);
                iBBSLevels(other_iBBSLvls).ms(index).indexs_beacons = iBBSLevels(other_iBBSLvls).ms(index).indexs_beacons(bolean_index);
            end
        end
        
        
        
    end 
    
    %% Protected Properties 
    for index = 1:length(iBBSLevels)
        iBBSLevels(index).inequality = inequality;
        iBBSLevels(index).extreme_value = extreme_value; 
        iBBSLevels(index).filterby = iBBSLevels(1).type;
        
    end
end


%% Validations 
%  ============

function boolean = BBSLevel_valid(iBBSLevel)
    boolean = false; 
    if ~isa(iBBSLevel,'BeaconBasedSgnLevel')
        error('The Parameter BBSLevel must be BBSLevel class')
    else
        boolean = true;
    end
end
function boolean = direction_valid(direction)
    boolean = false;
    options = {'>','<'};
    if ~ischar(direction)
        error('The direction parameter must be character.')
    elseif ~ismember(direction,options)
        error('The direction parameter must be < or >.')
    else 
        boolean = true;
    end
end


function boolean = extreme_values_valid(NumMaxAps)
    boolean = false;
    if ~isnumeric(NumMaxAps)
        error('The NumMaxAps parameter must be numeric.')
    else
        boolean = true;
    end
end