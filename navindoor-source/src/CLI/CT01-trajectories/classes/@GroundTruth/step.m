function results = step(iGroundTruth,t,varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'iGroundTruth')
    addRequired(p,'t')
    addOptional(p,'aceleration',false)
    addOptional(p,'gyro',false)
    addOptional(p,'att',false)
    addOptional(p,'stance',false)
    addOptional(p,'IndexLevel',false)
    addOptional(p,'IndexBuilding',false)
    addOptional(p,'all',false)

    parse(p,iGroundTruth,t,varargin{:})
    %
    aceleration = p.Results.aceleration;
    gyro        = p.Results.gyro;
    att         = p.Results.att;
    stance      = p.Results.stance;
    all         = p.Results.all;
    IndexBuilding = p.Results.IndexBuilding;
    IndexLevel  = p.Results.IndexLevel;
    Events = interp1(iGroundTruth.Events,iGroundTruth.timeline,t,'all',all,'gyro',gyro,'att',att,'stance',stance,'aceleration',aceleration);
    
    %%
    result.x = [];
    result.y = [];
    result.z = [];
    
    result.vx = [];
    result.vy = [];
    result.vz = [];
    
    result.t = [];

    if aceleration||all
        result.ax = [];
        result.ay = [];
        result.az = [];
    end
    if att||all
        result.attx = [];
        result.atty = [];
        result.attz = [];
    end
    if gyro||all
        result.gyrox = [];
        result.gyroy = [];
        result.gyroz = [];
    end   
    if stance||all
        result.stance = [];
    end
    
    results = repmat(result,1,length(t));
    %%
    for index = 1:length(t)
        results(index).x = Events(index).x;
        results(index).y = Events(index).y;
        results(index).z = Events(index).z;

        results(index).vx = Events(index).vx;
        results(index).vy = Events(index).vy;
        results(index).vz = Events(index).vz;

        results(index).t = t(index);
        if aceleration||all
            results(index).ax = Events(index).ax;
            results(index).ay = Events(index).ay;
            results(index).az = Events(index).az;
        end
        if att||all
            results(index).attx = Events(index).attx;
            results(index).atty = Events(index).atty;
            results(index).attz = Events(index).attz;
        end
        if gyro||all
            results(index).gyrox = Events(index).gyrox;
            results(index).gyroy = Events(index).gyroy;
            results(index).gyroz = Events(index).gyroz;
        end   
        if stance||all
            results(index).stance = Events(index).stance;
        end
        
        if IndexBuilding||all
            results(index).IndexBuilding = Events(index).IndexBuilding;
        end
        if IndexLevel||all
            results(index).IndexLevel = Events(index).IndexLevel;
        end
    end
end

