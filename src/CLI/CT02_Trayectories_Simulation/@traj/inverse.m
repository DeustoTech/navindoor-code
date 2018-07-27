function new_traj=inverse(trajectory)
    %% INVERSE 
    % construye una trayectoria donde el vertice final es el
    % inicial y viceversa. 
    %
    % *ENTRY:*
    %   - trajectory
    % *%% OUT VARIABLE:*
    %   - new inverse trayectory
    vertexs=zeros(1,trajectory.len,'vertex');
    for index = trajectory.len:-1:1
        vertexs(trajectory.len-index+1)= trajectory.nodes(index);
    end
    new_traj = traj(vertexs);
end
