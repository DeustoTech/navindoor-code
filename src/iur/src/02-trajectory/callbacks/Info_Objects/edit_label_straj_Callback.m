function edit_label_straj_Callback(object,event,h)
%EDIT_LABEL_STRAJ_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
index_straj = listbox_straj.Value;

h.trajectory_layer(index_straj).supertraj.label = object.String;
h.trajectory_layer(index_straj).label = object.String;

update_trajectory_layer(h)
end

