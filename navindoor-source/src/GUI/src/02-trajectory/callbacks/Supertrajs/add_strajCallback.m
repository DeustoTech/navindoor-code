function add_strajCallback(object,event,h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    h.trajectory_layer(end+1) = trajectory_layer;
    h.trajectory_layer(end).label = ['traj_',num2str(length(h.trajectory_layer),'%.3d')];
    update_trajectory_layer(h)
    
end
