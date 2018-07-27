function iBBS = filterAps(iBBS,inequality,extreme_value)
%FILTERAPS 
    % Parameters
    %   - iBBSLevels: List of BBSLevels object. The first element is used
    %   as order 
    %   - NumMaxAps: Integer number that is used to filter signals
    %   - direction: Parameter of sort function. 
    
    %% Parameters Asignment

    p = inputParser;p.KeepUnmatched = true; % active, if ther are optionals parameters 
   
    % Required Parameters 
    addRequired(p,'iBBS',@BBSLevel_valid);
    addRequired(p,'inequality',@direction_valid);
    addRequired(p,'extreme_value',@extreme_values_valid);
    
    parse(p,iBBS,inequality,extreme_value)
    
    
    for index_trajs = 1:length(iBBS(1).BeaconBasedSgnLevels)
         BBSLevels = arrayfun( @(index_signals) iBBS(index_signals).BeaconBasedSgnLevels(index_trajs),1:length(iBBS));
         new_BBSLevels = filterAps(BBSLevels,inequality,extreme_value);
         for index_signals = 1:length(iBBS)
             iBBS(index_signals).BeaconBasedSgnLevels(index_trajs) = new_BBSLevels(index_signals);
         end
         
         if index_trajs ~= length(iBBS(1).BeaconBasedSgnLevels)
             intersignal = iBBS(1).intersignal{index_trajs};
             % filter de first iBBS
             for index_ms_node = 1:length(intersignal)
                 values = intersignal(index_ms_node).values;
                 if strcmp(inequality,'>')
                    bolean_index = values > extreme_value;
                 elseif strcmp(inequality,'<')
                    bolean_index = values < extreme_value;
                 end
                 intersignal(index_ms_node).values         = intersignal(index_ms_node).values(bolean_index);
                 intersignal(index_ms_node).indexs_beacons = intersignal(index_ms_node).indexs_beacons(bolean_index); 
                 iBBS(1).intersignal{index_trajs} = intersignal;
                % other iBBS follow the first iBBS
                 if length(iBBS) > 1
                    for other_iBBSLvls = 2:length(iBBS)
                        intersignal = iBBS(other_iBBSLvls).intersignal{index_trajs};
                        intersignal(index_ms_node).values             = intersignal(index_ms_node).values(bolean_index);
                        intersignal(index_ms_node).indexs_beacons     = intersignal(index_ms_node).indexs_beacons(bolean_index); 
                        iBBS(other_iBBSLvls).intersignal{index_trajs} = intersignal;                        
                    end   
                 end
             end

 
         end
         
    end
    
end

%% Validations 
%  ============

function boolean = BBSLevel_valid(iBBSLevel)
    boolean = false; 
    if ~isa(iBBSLevel,'BeaconBasedSgn')
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