function listbox_strajCallback(object,event,h)
%LISTBOX_STRAJCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    axes_trajectory = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Graphs','axes');
    delete(axes_trajectory.Children);
    
    listbox_level = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Levels','listbox');
    index_level = listbox_level.Value;
    plot(h.planimetry_layer,index_level,axes_trajectory);
    
    
    update_trajectory_layer(h);

end

