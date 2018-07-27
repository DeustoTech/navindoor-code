function btn_animationCallback(object,event,h)
%BTN_ANIMATIONCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    listbox_levels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
    index_straj = listbox_levels.Value;
    straj = h.trajectory_layer(index_straj).supertraj;

    animation(straj,h.planimetry_layer(1).build,'xx',4.0)
end

