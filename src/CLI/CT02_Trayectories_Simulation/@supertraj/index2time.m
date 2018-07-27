function Tcurrent = index2time(istraj,index_traj,index_node)
%INDEX Summary of this function goes here
%   Detailed explanation goes here
    
    %% Input parameters
    p = inputParser;p.KeepUnmatched = true; % active, if ther are optionals parameters 
    
    % Mandatories
    addRequired(p,'istraj',@straj_valid);
    addRequired(p,'index_traj',@index_valid);
    addRequired(p,'index_node',@index_valid);

    parse(p,istraj,index_traj,index_node)
    
    if strcmp(index_traj,"end")
        index_traj = istraj.len;
    end
    
    if strcmp(index_node,"end")
        index_node = istraj.trajs(index_traj).len;
    end
    
    
    Tbefore = sum([istraj.trajs(1:index_traj-1).len])*istraj.dt;
    Tinterlevel = sum_interlevel(istraj,index_traj);

    Tcurrent = istraj.trajs(index_traj).t(index_node) + istraj.dt;
    
    if ~isempty(Tbefore)
        Tcurrent = Tcurrent + Tbefore + Tinterlevel - istraj.dt;
    end            
        

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
function Tbefore = sum_interlevel(istraj,index_traj)
    Tbefore = 0;
    for index = 1:index_traj-1
        mt = istraj.dt_connections{index};
        Tbefore = Tbefore + height(mt(:,1))*istraj.dt;
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