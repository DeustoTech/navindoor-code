function result = time2index(istraj,t)
% TIME2INDEX Summary of this function goes here
%   Detailed explanation goes here
    
    p = inputParser;
    
    addRequired(p,'istraj',@istraj_valid)
    addRequired(p,'t',@(t) t_valid(t,istraj))

    %% INIT
    
    dt = istraj.dt;
    n = round(t/dt) + 1;
    
    for index_trajs = 1: istraj.len
        itraj = istraj.trajs(index_trajs);
        n = n - itraj.len;
        if n <= 0
            n = n + itraj.len;
            result.index_trajs = index_trajs;
            result.index_nodes = n;
            result.interlevel  = false;
            return
        end
        
        if index_trajs ~= istraj.len
        % se ejecuta siempre que no sea el ultimo
            mt = istraj.dt_connections{index_trajs};
            nt_con = mt(:,1);
            nt_con = height(nt_con);
            n = n - nt_con;
            if n <= 0
                n = n + nt_con;
                result.index_trajs = index_trajs;
                result.index_nodes = n;
                result.interlevel  = true;
                return
            end
        end
    end
    
    
    
end

function boolean = istraj_valid(istraj)
    boolean = false;
    if istraj.dt == 0
        error('The parameter istraj must has velocity. Try use the "velocity" function.')
    else 
        boolean = true;
    end

end

function boolean = t_valid(t,istraj)
    boolean = false;
    if ~isnumeric(t)
        error('The parameter t must be numeric')
    elseif istraj.dt_max < t
        error('The parameter t must be lower that dt_max property of supertraj')
    else
        boolean = true;
    end
    
end
