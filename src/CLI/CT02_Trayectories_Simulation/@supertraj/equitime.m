function istraj = equitime(istraj,dt)
%% EQUITIME 


    for index_itraj=1:istraj.len 
        istraj.trajs(index_itraj) = equitime(istraj.trajs(index_itraj),dt);
    end
    istraj.dt_connections = round(istraj.dt_connections/dt)*dt;
    istraj.equitime = true; 
    istraj.dt_equitime = dt;

end

