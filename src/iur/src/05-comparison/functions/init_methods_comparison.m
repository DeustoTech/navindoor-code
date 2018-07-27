function init_methods_comparison(object,event,h)
%INIT_SIGNAL_PROCESSING Summary of this function goes here
%   Detailed explanation goes here

    %% index Supertraj
    listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');
    index_straj = listbox_supertraj.Value;
    
    listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Methods Comparison','Supertraj','listbox');

    listbox_straj.String =  {h.trajectory_layer.label};

    %% Signals Aviable 

    for itrajlayer = h.trajectory_layer
        estimators = {};
        index = 0;
        for iprocessinglayer = itrajlayer.processing_layer
           if ~isempty(iprocessinglayer.supertraj)
               index  = index + 1;
               estimators{index}= iprocessinglayer;
           end
        end
        itrajlayer.aviable_estimators = estimators;
    end
    
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
    set(jScrollPane,'MouseClickedCallback',{@estimator_available_callback,h})
    h.javacomponets.comparison_layer.list_estimators.object = jCBList;

update_method_comparison(h)
