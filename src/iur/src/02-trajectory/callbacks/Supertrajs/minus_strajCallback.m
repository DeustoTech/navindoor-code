function minus_strajCallback(object,event,h)
%MINUS_STRAJCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    if length(h.trajectory_layer) > 1
        listboxstrajs = findobj_figure(h.iur_figure,'Trajectory','Supertraj','listbox');
        listboxstrajs.Value = 1;
        
        h.trajectory_layer(end) = [];
        update_trajectory_layer(h)
    end
end

