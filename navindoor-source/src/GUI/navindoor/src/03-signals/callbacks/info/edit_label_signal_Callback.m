function edit_label_signal_Callback(object,event,h)
%EDIT_LABEL_STRAJ_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');
index_signals = listbox_signals.Value;

listbox_straj= findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
index_straj = listbox_straj.Value;




h.trajectory_layer(index_straj).signal_layer(index_signals).label = object.String;

if ~isempty(h.trajectory_layer(index_straj).signal_layer(index_signals).signal)
    h.trajectory_layer(index_straj).signal_layer(index_signals).signal.label = object.String;
end

update_signal_layer(h)
end

