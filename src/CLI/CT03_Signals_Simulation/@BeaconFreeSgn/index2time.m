function Tcurrent = index2time(iBBS,index_traj,index_node,varargin)
%INDEX Summary of this function goes here
%   Detailed explanation goes here
    
    %% Input parameters
    p = inputParser;p.KeepUnmatched = true; % active, if ther are optionals parameters 
    
    % Mandatories
    addRequired(p,'iBBS',@straj_valid);
    addRequired(p,'index_traj',@index_valid);
    addRequired(p,'index_node',@index_valid);
    addOptional(p,'inlevel',true);

    parse(p,iBBS,index_traj,index_node,varargin{:})
    
    inlevel = p.Results.inlevel;
    
    if strcmp(index_traj,"end")
        if inlevel
            index_traj = length(iBBS.BeaconFreeSgnLevels);
        else
            index_traj = length(iBBS.BeaconFreeSgnLevels) - 1;
        end
    end
    
    if strcmp(index_node,"end")
        if inlevel
            index_node = iBBS.BeaconFreeSgnLevels(index_traj).len;
        else
            index_node = length(iBBS.intersignal{index_traj});
        end
    end
    
    if inlevel
       Tcurrent =  iBBS.BeaconFreeSgnLevels(index_traj).ms(index_node).t;
    else
       Tcurrent =  iBBS.intersignal{index_traj}(index_node).t;
    end
        
    Tcurrent = Tcurrent + sum_interlevel(iBBS,index_traj,inlevel);

end
%% Validations 
function boolean = straj_valid(istraj)
    boolean = false;
    if istraj.dt == 0
        error('The parameter straj must have velocity. Try use supertraj/velocity to generate a supertraj with velocity.')
    else
        boolean = true;
    end
end
function Tbefore = sum_interlevel(iBBS,index_traj,inlevel)
    Tbefore = 0;
    for index = 1:index_traj-1
        Tbefore = Tbefore + iBBS.BeaconFreeSgnLevels(index).ms(end).t + iBBS.dt;
        Tbefore = Tbefore + iBBS.intersignal{index}(end).t + iBBS.dt;
    end

    if ~inlevel 
        Tbefore = Tbefore + iBBS.BeaconFreeSgnLevels(index_traj).ms(end).t + iBBS.dt;
    end
end

function boolean = index_valid(index)
   boolean = false;
    if ~((isnumeric(index) && floor(index) == index)||index == 'end')
        error('The parameter index only can be numeric or "end"')
    else
        boolean = true;
    end
end