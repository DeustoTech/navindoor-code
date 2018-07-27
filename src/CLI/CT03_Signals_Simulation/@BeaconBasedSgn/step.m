function result = step(iBBS,t,varargin)
%STEP Summary of this function goes here
%   Detailed explanation goes here
    
    p = inputParser;
    
    addRequired(p,'iBBS',@istraj_valid)
    addRequired(p,'t',@(t) t_valid(t,iBBS))
    
    parse(p,iBBS,t,varargin{:})
    
    
    t2ir = time2index(iBBS,t);
    it = t2ir.index_BBSL;
    in = t2ir.index_nodes;
    
    if t2ir.interlevel
        ms_nodes  = iBBS.intersignal{it};
        
        result.values = ms_nodes(in).values;
        result.beacons = [iBBS.BeaconBasedSgnLevels(it).beacons iBBS.BeaconBasedSgnLevels(it+1).beacons];
        result.beacons = result.beacons(ms_nodes(in).indexs_beacons);
        
        % bb = beacons before; ba = beacons after
        len_bb   = length(iBBS.BeaconBasedSgnLevels(it).beacons);
        len_ba   = length(iBBS.BeaconBasedSgnLevels(it + 1).beacons);
        hight_bb = iBBS.BeaconBasedSgnLevels(it).hight;
        hight_ba = iBBS.BeaconBasedSgnLevels(it + 1).hight;
        
        result.hight_beacons = [repmat(hight_bb,1,len_bb) repmat(hight_ba,1,len_ba)];
        
        %% MODIFICAR
        result.values = [];
        result.beacons = [];
        result.hight_beacons = [];
        %%
        
    else
        ims = iBBS.BeaconBasedSgnLevels(it).ms(in);
        beacons = iBBS.BeaconBasedSgnLevels(it).beacons;
        
        result.beacons = beacons(ims.indexs_beacons);
        result.values  = ims.values;
        
        % b = beacons ; 
        len_b   = length(iBBS.BeaconBasedSgnLevels(it).beacons);
        hight_b = iBBS.BeaconBasedSgnLevels(it).hight;
        
        result.hight_beacons = repmat(hight_b,1,len_b);
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

function boolean = t_valid(t,iBBS)
    boolean = false;
    if ~isnumeric(t)
        error('The parameter t must be numeric')
    elseif round(iBBS.dt_max,10) < round(t,10)
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
    