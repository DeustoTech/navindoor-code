function listboxSupertrajComparisonCallback(object,event,h)
%LISTBOXSUPERTRAJPROCESSINGCALLBACK Summary of this function goes here
%   Detailed explanation goes here

listbox_straj = findobj_figure(h.iur_figure,'Signal Processing','Supertraj','listbox');
index_straj = listbox_straj.Value;

listbox_estimators = findobj_figure(h.iur_figure,'Signal Processing','Estimators','listbox');
index_processing  = listbox_estimators.Value;

h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.signals = [];



    %% Update Estimator Avialabel 
    panel_estimator_aviable = findobj_figure(h.iur_figure,'tabgroup','Methods Comparison','Estimators Available');
    delete(panel_estimator_aviable.Children)
    
    index = 1;
    jList = java.util.ArrayList;  % any java.util.List will be ok

    for iestimator = h.trajectory_layer(index_straj).aviable_estimators
        if ~isempty(iestimator)
            jList.add(index-1,iestimator{:}.label);
            index = index + 1;
        end
    end
    
    jCBList = com.mathworks.mwswing.checkboxlist.CheckBoxList(jList);
    jScrollPane = com.mathworks.mwswing.MJScrollPane(jCBList);
    [jhCBList,hContainer] = javacomponent(jScrollPane,[10,10,80,65],panel_estimator_aviable);
    hContainer.Units = 'normalized';
    hContainer.Position = [0.1 0.1 0.8 0.8];
    hContainer.Tag = 'listbox';
    set(jhCBList,'MouseClickedCallback',{@estimator_available_callback,h})
    
    h.javacomponets.comparison_layer.list_estimators.object = jCBList;

    
update_method_comparison(h)
%% Double Click - Funcionality
persistent chk
if isempty(chk)
      chk = 1;
      pause(0.25); %Add a delay to distinguish single click from a double click
      if chk == 1
          chk = [];
      end
else
    chk = [];
    listbox_strajs = findobj_figure(h.iur_figure,'Methods Comparison','Supertraj','listbox');
    index_strajs = listbox_strajs.Value;

    straj = h.trajectory_layer(index_strajs).supertraj;
    if ~isempty(straj.trajs)
        TableOfObjects(straj);
    end
end
    



end

