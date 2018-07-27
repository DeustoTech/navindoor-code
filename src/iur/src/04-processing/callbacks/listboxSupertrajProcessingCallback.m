function listboxSupertrajProcessingCallback(object,event,h)
%LISTBOXSUPERTRAJPROCESSINGCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    listbox_straj = findobj_figure(h.iur_figure,'Signal Processing','Supertraj','listbox');
    index_straj = listbox_straj.Value;

    listbox_estimators = findobj_figure(h.iur_figure,'Signal Processing','Estimators','listbox');
    index_processing  = listbox_estimators.Value;

    h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.signals = [];
    update_processing_layer(h)
    
    persistent chk
    if isempty(chk)
          chk = 1;
          pause(0.25); %Add a delay to distinguish single click from a double click
          if chk == 1
              chk = [];
          end
    else
        chk = [];
        
        straj = h.trajectory_layer(index_straj).supertraj;
        if ~isempty(straj.trajs)
            TableOfObjects(straj);
        end
    end
    
end

