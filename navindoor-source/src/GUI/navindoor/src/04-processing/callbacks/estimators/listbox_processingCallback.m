function listbox_processingCallback(object,event,h)
%LISTBOX_PROCESSINGCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    
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
        listbox_estimators = findobj_figure(h.iur_figure,'Signal Processing','Estimators','listbox');
        index_estimators = listbox_estimators.Value;
        
        listbox_straj = findobj_figure(h.iur_figure,'Signal Processing','Supertraj','listbox');
        index_straj = listbox_straj.Value;
        
        estimator = h.trajectory_layer(index_straj).processing_layer(index_estimators).estimator;
        if ~isempty(estimator.estimation)
            TableOfObjects(estimator);
        end
    end
end

