function listbox_trajectoryCallback(object,event,h)
%LISTBOX_TRAJECTRYCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    axes_trajectory = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Graphs','axes');
    delete(axes_trajectory.Children)
    
    index_level = object.Value;
    plot(h.planimetry_layer,index_level,axes_trajectory);
    
    update_trajectory_layer(h)

end

