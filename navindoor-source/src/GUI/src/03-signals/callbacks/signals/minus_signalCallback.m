function minus_signalCallback(object,event,h)
%MINUS_SIGNALCALLBACK Summary of this function goes here
%   Detailed explanation goes here

%% index Supertraj
listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
index_straj = listbox_supertraj.Value;
    

    if length(h.trajectory_layer(index_straj).signal_layer) > 1
        listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');
        listbox_signals.Value = 1;
        h.trajectory_layer(index_straj).signal_layer(end) = [];
        update_signal_layer(h)
    end
end

