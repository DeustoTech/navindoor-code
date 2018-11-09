function add_signalCallback(object,event,h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
%% index Supertraj
listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
index_straj = listbox_supertraj.Value;
    

h.trajectory_layer(index_straj).signal_layer(end+1) = signal_layer;
h.trajectory_layer(index_straj).signal_layer(end).label = ['signal_',num2str(length(h.trajectory_layer(index_straj).signal_layer),'%.3d')];
    
update_signal_layer(h)
end

