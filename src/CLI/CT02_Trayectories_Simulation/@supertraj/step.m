function result = step(istraj,t,varargin)
%STEP Summary of this function goes here
%   Detailed explanation goes here
    
    p = inputParser;
    
    addRequired(p,'istraj',@istraj_valid)
    addRequired(p,'t',@(t) t_valid(t,istraj))
    
    addOptional(p,'hight',false,@boolean_valid)
    addOptional(p,'velocity',false,@boolean_valid)
    addOptional(p,'aceleration',false,@boolean_valid)
    addOptional(p,'angle',false,@boolean_valid)
    addOptional(p,'all',false,@boolean_valid)
    
    
    parse(p,istraj,t,varargin{:})
    
    velocity    = p.Results.velocity;
    angle       = p.Results.angle;
    aceleration = p.Results.aceleration;
    hight       = p.Results.hight;    
    all         = p.Results.all;
    
    if all
        velocity    = true;
        angle       = true;
        aceleration = true;
        hight       = true;
    end
    
    
    t2ir = time2index(istraj,t);
    it = t2ir.index_trajs;
    in = t2ir.index_nodes;
    itraj = istraj.trajs(it);
    
    if t2ir.interlevel
        x = itraj.nodes(end).r(1);
        y = itraj.nodes(end).r(2);

        mt = istraj.dt_connections{it};
    else
        x = itraj.nodes(in).r(1);
        y = itraj.nodes(in).r(2);
    end
    
    % Ouput format
    result.t = t;
    result.x = x;
    result.y = y;
    %%
    if velocity
        if t2ir.interlevel
            vx = 0;
            vy = 0;
            interlevel = true;
        else
            v = itraj.v(in);
            vx = v*cos(itraj.angles(in));
            vy = v*sin(itraj.angles(in));
            interlevel = false;

        end        
        result.vx = vx;
        result.vy = vy;
        result.interlevel = interlevel;

    end
    %%
    if aceleration
        if t2ir.interlevel
            ax = 0;
            ay = 0;
        else
            a = itraj.v(in);
            ax = a*cos(itraj.angles(in));
            ay = a*sin(itraj.angles(in));
        end        
        result.ax = ax;
        result.ay = ay;        
    end
    %%
    if angle
        if t2ir.interlevel
            result.angles = [];
        else
            result.angles = itraj.angles(in);
        end
    end
    %%
    if hight
        if t2ir.interlevel
            table_inter = istraj.dt_connections{it};
            result.h    = table_inter.h(in);
        else
            result.h = itraj.hight;
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
    elseif round(istraj.dt_max,8) < round(t,8)
        error('The parameter t must be lower that dt_max property of supertraj')
    else
        boolean = true;
    end
    
end

function boolean = boolean_valid(velocity) 
    boolean = false;
    if ~islogical(velocity)
        error('The velocity parameter must be logical')
    else
        boolean = true;
    end
    
end
    