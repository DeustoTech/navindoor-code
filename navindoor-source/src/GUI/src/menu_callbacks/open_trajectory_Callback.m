function open_trajectory_Callback(object,event,h)
%OPEN_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
    [namemat,path] = uigetfile('*.mat','Select the MATLAB code file');
    
    if namemat ~= 0
        file = strcat(path,namemat);
        load(file, 'itraj')

        listbox = findobj_figure(h.iur_figure,'Trajectory','Supertraj','listbox');
        index_traj = listbox.Value;
        
        
        h.trajectory_layer(index_traj).traj = itraj;
        h.trajectory_layer(index_traj).byFloorFcn = char(itraj.byFloorFcn);
        h.trajectory_layer(index_traj).byStairsFcn = char(itraj.byStairsFcn);
        h.trajectory_layer(index_traj).byElevatorsFcn = char(itraj.byElevatorsFcn);
        h.trajectory_layer(index_traj).foot2RefFcn = char(itraj.foot2RefFcn);
        h.trajectory_layer(index_traj).label = itraj.label;
        h.trajectory_layer(index_traj).segments = itraj.segments;
        h.trajectory_layer(index_traj).points = itraj.points;

        h.trajectory_layer(index_traj).signal_layer = signal_layer;
        h.trajectory_layer(index_traj).processing_layer = processing_layer;

        
        axes_trajectory = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Graphs','axes');
        delete(axes_trajectory.Children);

        listbox_level = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Levels','listbox');
        index_level = listbox_level.Value;

        plot(h.planimetry_layer,index_level,axes_trajectory);
    
    
        update_trajectory_layer(h,'layer',true)

    end
    
end

