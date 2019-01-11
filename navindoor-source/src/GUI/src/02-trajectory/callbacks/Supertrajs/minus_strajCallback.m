function minus_strajCallback(object,event,h)
%MINUS_STRAJCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    listboxstrajs = findobj_figure(h.iur_figure,'Trajectory','Supertraj','listbox');

    if length(h.trajectory_layer) > 1
        
        h.trajectory_layer(listboxstrajs.Value) = [];
        
        listboxstrajs.Value = 1;

        update_trajectory_layer(h)
    end
end

