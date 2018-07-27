function result = time2index(BBS,t)
% TIME2INDEX Summary of this function goes here
%   Detailed explanation goes here
    
    p = inputParser;
    
    addRequired(p,'BBS',@istraj_valid)
    addRequired(p,'t',@(t) t_valid(t,BBS))

    %% INIT
    
    dt = BBS.dt;
    n = round(t/dt) + 1;
    
    for index_BBSLs = 1:length(BBS.BeaconBasedSgnLevels)
        BBSL = BBS.BeaconBasedSgnLevels(index_BBSLs);
        n = n - BBSL.len;
        if n <= 0
            n = n + BBSL.len;
            result.index_BBSL = index_BBSLs;
            result.index_nodes = n;
            result.interlevel  = false;
            return
        end
        
        if index_BBSLs ~= length(BBS.BeaconBasedSgnLevels)
            mt = BBS.intersignal{index_BBSLs};
            nt_con = mt(:,1);
            nt_con = length(nt_con);
            n = n - nt_con;
            if n <= 0
                n = n + nt_con;
                result.index_BBSL = index_BBSLs;
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
