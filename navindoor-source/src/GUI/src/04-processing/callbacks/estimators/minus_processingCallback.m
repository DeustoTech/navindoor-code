function minus_processingCallback(object,event,h)
%MINUS_SIGNALCALLBACK Summary of this function goes here
%   Detailed explanation goes here


%% index Supertraj

listbox_straj = findobj_figure(h.iur_figure,'Signal Processing','Supertraj','listbox');
index_straj = listbox_straj.Value;


listbox_estimator = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Estimators','listbox');


    if length(h.AvailableTraj(index_straj).processing_layer) > 1
        h.AvailableTraj(index_straj).processing_layer(listbox_estimator.Value) = [];
        listbox_estimator.Value = 1;

        update_processing_layer(h)
    end
end

