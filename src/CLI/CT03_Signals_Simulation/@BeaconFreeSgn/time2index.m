function result = time2index(BFS,t)
% TIME2INDEX Summary of this function goes here
%   Detailed explanation goes here
    
    p = inputParser;
    
    addRequired(p,'BFS',@istraj_valid)
    addRequired(p,'t',@(t) t_valid(t,BFS))

    %% INIT
    
    dt = BFS.dt;
    n = round(t/dt) + 1;
    
    for index_BFSLs = 1:length(BFS.BeaconFreeSgnLevels)
        BBSL = BFS.BeaconFreeSgnLevels(index_BFSLs);
        n = n - BBSL.len;
        if n <= 0
            n = n + BBSL.len;
            result.index_BFSL = index_BFSLs;
            result.index_nodes = n;
            result.interlevel  = false;
            return
        end
        
        if index_BFSLs ~= length(BFS.BeaconFreeSgnLevels)
            nt_con = length(BFS.intersignal{index_BFSLs});
            n = n - nt_con;
            if n <= 0
                n = n + nt_con;
                result.index_BFSL = index_BFSLs;
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
