function add_processingCallback(object,event,h)
%ADD_PROCESSINGCALLBACK Summary of this function goes here
%   Detailed explanation goes here


listbox_strajs = findobj_figure(h.iur_figure,'Signal Processing','Supertraj','listbox');
index_straj = listbox_strajs.Value;


index_estimator = length(h.trajectory_layer(index_straj).processing_layer) + 1;
h.trajectory_layer(index_straj).processing_layer(index_estimator)= processing_layer;
h.trajectory_layer(index_straj).processing_layer(index_estimator).label = ['estimator_',num2str(length(h.trajectory_layer(index_straj).processing_layer),'%.3d')];
    
update_processing_layer(h)
end

