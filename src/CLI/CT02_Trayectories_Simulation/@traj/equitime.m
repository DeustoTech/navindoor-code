function itraj = equitime(itraj,dt)
%% EQUITIME 
   %% Parameter Assignment 
    p = inputParser;
    addRequired(p,'itraj',@traj_valid_velocity);
    addRequired(p,'dt',@dt_valid);
   
    p.KeepUnmatched = false;
    parse(p,itraj,dt)
        
    %% Init
    tf = itraj.t(end);
    ti = 0;
    %% Interpolate of v x 
    new_t = ti:dt:tf;
    new_x     = arrayfun(@(t) interp1(itraj.t,itraj.x,t),new_t);
    new_nodes = arrayfun(@(x) x2vertex(itraj,x),new_x);
    new_v     = arrayfun(@(t) interp1(itraj.t,itraj.v,t),new_t);

    
    %% Save the properties
    label = itraj.label;
    level = itraj.level;
    has_velocity = itraj.has_velocity;
   
    itraj=traj(new_nodes); %% <- remove all propeties 
    itraj.x = new_x;
    itraj.v = new_v;
    itraj.t = new_t;
    
    %% Private Properties Corrected 
    itraj.equitime = true;
    itraj.dt = dt;
    %% Re assigment properties 
    itraj.label = label;
    itraj.level = level;
    itraj.has_velocity = has_velocity;

end