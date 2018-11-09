function checkbox_bydefault(object,event,h)
%CHECKBOX_BYDEFAULT Summary of this function goes here
%   Detailed explanation goes here
%% Tab Signal Processing
    tab_signal_processing = findobj_figure(h.iur_figure,'tabgroup','Signal Processing');
%% Indexs 
    % supertraj
    listbox_supertraj = findobj_figure(tab_signal_processing,'Supertraj','listbox');
    index_straj = listbox_supertraj.Value;
    % estimators
    listbox_estimators = findobj_figure(tab_signal_processing,'Estimators','listbox');
    index_processing  = listbox_estimators.Value;
%%
    h.trajectory_layer(index_straj).processing_layer(index_processing).InitState_default = object.Value;

    update_processing_layer(h)
end

