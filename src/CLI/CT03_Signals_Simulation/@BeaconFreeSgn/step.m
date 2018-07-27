function result = step(iBFS,t,varargin)
%STEP Summary of this function goes here
%   Detailed explanation goes here
    
    p = inputParser;
    
    addRequired(p,'iBFS',@istraj_valid)
    addRequired(p,'t',@(t) t_valid(t,iBFS))
    
    addOptional(p,'inlevel',false,@boolean_valid)
    
    parse(p,iBFS,t,varargin{:})
    
    inlevel = p.Results.inlevel;
    
    t2ir = time2index(iBFS,t);
    it = t2ir.index_BFSL;
    in = t2ir.index_nodes;
    
    if t2ir.interlevel
        table  = iBFS.intersignal{it};
        result.values = table(in).values;
    else
        ims = iBFS.BeaconFreeSgnLevels(it).ms(in);
        
        result.values  = ims.values;

    end
    
    if inlevel
        if t2ir.interlevel
            result.inlevel = true;
        else
            result.inlevel = false;
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

function boolean = t_valid(t,iBFS)
    boolean = false;
    if ~isnumeric(t)
        error('The parameter t must be numeric')
    elseif round(iBFS.dt_max,10) < round(t,10)
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
    