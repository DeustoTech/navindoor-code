function estimator_available_callback(object,event,h)
%ESTIMATOR_AVAILABLE_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
    
    update_method_comparison(h)

    persistent chk
    if isempty(chk)
          chk = 1;
          pause(0.25); %Add a delay to distinguish single click from a double click
          if chk == 1
              chk = [];
          end
    else
        chk = [];
        listbox_estimators = findobj_figure(h.iur_figure,'Methods Comparison','Estimators Availabel','listbox');
        index_estimators = listbox_estimators.Value;
        
        listbox_strajs = findobj_figure(h.iur_figure,'Methods Comparison','Supertraj','listbox');
        index_strajs = listbox_strajs.Value;
        
        estimator = h.trajectory_layer(index_strajs).processing_layer(index_estimators).estimator;
        if ~isempty(estimator)
            TableOfObjects(estimator);
        end
    end
    
end

