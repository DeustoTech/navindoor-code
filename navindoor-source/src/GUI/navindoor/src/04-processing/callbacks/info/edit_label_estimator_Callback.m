function edit_label_estimator_Callback(object,event,h)
%EDIT_LABEL_STRAJ_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
%%
listbox_estimators = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Estimators','listbox');
index_estimators = listbox_estimators.Value;



%% index Supertraj

listbox_straj = findobj_figure(h.iur_figure,'Signal Processing','Supertraj','listbox');
index_straj = listbox_straj.Value;

h.trajectory_layer(index_straj).processing_layer(index_estimators).label = object.String;
h.trajectory_layer(index_straj).processing_layer(index_estimators).estimator.label = object.String;

update_processing_layer(h)
end

