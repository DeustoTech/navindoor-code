function update_method_comparison(h)
%UPDATE_TRAJECTORY_LAYER Summary of this function goes here
%   Detailed explanation goes here



%
%% Index Supertraj
listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Methods Comparison','Supertraj','listbox');
index_straj = listbox_supertraj.Value;
    
jList = java.util.ArrayList;  % any java.util.List will be ok

index = 0;
for iestimator = h.AvailableTraj(index_straj).aviable_estimators
    index = index + 1;
    jList.add(index-1,iestimator.label);
end
%%
    
panel_estimator_aviable = findobj_figure(h.iur_figure,'Methods Comparison','Estimators Available');

jCBList = com.mathworks.mwswing.checkboxlist.CheckBoxList(jList);
jScrollPane = com.mathworks.mwswing.MJScrollPane(jCBList);
[jhCBList,hContainer] = javacomponent(jScrollPane,[10,10,80,65],panel_estimator_aviable);
    hContainer.Units = 'normalized';
    hContainer.Position = [0.1 0.1 0.8 0.8];
    hContainer.Tag = 'listbox';
    set(jScrollPane,'MouseClickedCallback',{@estimator_available_callback,h})
    h.javacomponets.comparison_layer.list_estimators.object = jCBList;

h.AvailableTraj(index_straj).jCBList = h.javacomponets.comparison_layer.list_estimators.object ;
 
 
 
 
 


 
%% 
