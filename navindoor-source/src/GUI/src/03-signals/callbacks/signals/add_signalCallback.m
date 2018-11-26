function add_signalCallback(object,event,h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
%% index Supertraj
listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
index_straj = listbox_supertraj.Value;
    
%%
 prompt={'Enter the name of new signal layer'};
 name='Input for Peaks function';
 defaultanswer={['sgn_',num2str(1+length(h.AvailableTraj(index_straj).signal_layer),'%.3d')]};    
 numlines = 1;

 answer=inputdlg(prompt,name,numlines,defaultanswer);
if isempty(answer)
   return 
end

h.AvailableTraj(index_straj).signal_layer(end+1) = signal_layer;
h.AvailableTraj(index_straj).signal_layer(end).label = answer{:};
    
update_signal_layer(h)
end

