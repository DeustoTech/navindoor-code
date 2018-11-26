function add_processingCallback(object,event,h)
%ADD_PROCESSINGCALLBACK Summary of this function goes here
%   Detailed explanation goes here

%%

%% index Supertraj
listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');
index_straj = listbox_supertraj.Value;
    
%%
 prompt={'Enter the name of new processing layer'};
 name='Input for Peaks function';
 defaultanswer={['estimator_',num2str(1+length(h.AvailableTraj(index_straj).processing_layer),'%.3d')]};    
 numlines = 1;

 answer=inputdlg(prompt,name,numlines,defaultanswer);
if isempty(answer)
   return 
end

h.AvailableTraj(index_straj).processing_layer(end+1) = processing_layer;
h.AvailableTraj(index_straj).processing_layer(end).label = answer{:};
    
update_processing_layer(h)
end

