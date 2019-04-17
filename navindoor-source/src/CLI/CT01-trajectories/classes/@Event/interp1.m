function outEvents = interp1(Events,timeline,new_timeline,varargin)
%INTERP1 

    p = inputParser;
    addRequired(p,'Events')
    addRequired(p,'timeline')
    addRequired(p,'new_timeline')
    addOptional(p,'aceleration',false)
    addOptional(p,'gyro',false)
    addOptional(p,'att',false)
    addOptional(p,'stance',false)
    addOptional(p,'IndexBuilding',true)
    addOptional(p,'IndexLevel',true)

    addOptional(p,'all',false)
    addOptional(p,'method','nearest')
    parse(p,Events,timeline,new_timeline,varargin{:})
    
    Events       = p.Results.Events;
    timeline     = p.Results.timeline;
    new_timeline = p.Results.new_timeline;
    method       = p.Results.method;
    aceleration  = p.Results.aceleration;
    gyro         = p.Results.gyro;
    att          = p.Results.att;
    all          = p.Results.all;
    stance       = p.Results.stance;
    IndexBuilding = p.Results.IndexBuilding;
    IndexLevel  = p.Results.IndexLevel;
    %%
    
    % interpolate in space
    new_x = interp1(timeline,[Events.x],new_timeline,method);
    new_y = interp1(timeline,[Events.y],new_timeline,method);
    new_z = interp1(timeline,[Events.z],new_timeline,method);
    if (all||aceleration)
        new_vx = interp1(timeline,[Events.vx],new_timeline,method);
        new_vy = interp1(timeline,[Events.vy],new_timeline,method);
        new_vz = interp1(timeline,[Events.vz],new_timeline,method);
        new_ax = interp1(timeline,[Events.ax],new_timeline,method);
        new_ay = interp1(timeline,[Events.ax],new_timeline,method);
        new_az = interp1(timeline,[Events.ax],new_timeline,method);
    end
    if gyro||all
        new_gyrox = interp1(timeline,[Events.gyrox],new_timeline,method);
        new_gyroy = interp1(timeline,[Events.gyroy],new_timeline,method);
        new_gyroz = interp1(timeline,[Events.gyroz],new_timeline,method);
    end
    
    if att||all
        new_attx = interp1(timeline,[Events.attx],new_timeline,method);
        new_atty = interp1(timeline,[Events.atty],new_timeline,method);
        new_attz = interp1(timeline,[Events.attz],new_timeline,method);
    end
    if stance||all
        new_stance = interp1(timeline,[Events.stance],new_timeline,method);
    end
    if IndexBuilding||all
        new_IndexBuilding = interp1(timeline,[Events.IndexBuilding],new_timeline,method);
    end
    if IndexLevel||all
        new_IndexLevel = interp1(timeline,[Events.IndexLevel],new_timeline,method);
    end
    
    index = 0;
    outEvents = Event.empty;
    for t = new_timeline
        index = index + 1;
        outEvents(index).r = [new_x(index) new_y(index) new_z(index)];
  
        if aceleration||all
            outEvents(index).vx = new_vx(index);
            outEvents(index).vy = new_vy(index);
            outEvents(index).vz = new_vz(index);            
            outEvents(index).ax = new_ax(index);
            outEvents(index).ay = new_ay(index);
            outEvents(index).az = new_az(index);
        end        
        if att||all
            outEvents(index).attx = new_attx(index);
            outEvents(index).atty = new_atty(index);
            outEvents(index).attz = new_attz(index);
        end
        if gyro||all
            outEvents(index).gyrox = new_gyrox(index);
            outEvents(index).gyroy = new_gyroy(index);
            outEvents(index).gyroz = new_gyroz(index);
        end   
        if stance||all
            outEvents(index).stance = new_stance(index);
        end
        
        if IndexBuilding||all
            outEvents(index).IndexBuilding = new_IndexBuilding(index);
        end
        
        if IndexLevel||all
            outEvents(index).IndexBuilding = new_IndexLevel(index);
        end
    end
    %% velocity
    if ~(all||aceleration)
        new_vx = gradient([outEvents.x],new_timeline);
        new_vy = gradient([outEvents.y],new_timeline);
        new_vz = gradient([outEvents.z],new_timeline);

        for index = 1:length(new_timeline)
            outEvents(index).vx = new_vx(index);
            outEvents(index).vy = new_vy(index);
            outEvents(index).vz = new_vz(index);
        end
    end
end

