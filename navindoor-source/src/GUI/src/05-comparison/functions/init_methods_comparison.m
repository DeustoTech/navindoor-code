function init_methods_comparison(object,event,h)
%INIT_SIGNAL_PROCESSING Summary of this function goes here
%   Detailed explanation goes here

%     %% index Supertraj
%     listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Methods Comparison','Supertraj','listbox');
%     index_straj = listbox_supertraj.Value;
%     
%     listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Methods Comparison','Supertraj','listbox');
% 
%     listbox_straj.String =  {h.trajectory_layer.label};

    %% Signals Aviable 

%     for itrajlayer = h.trajectory_layer
%         estimators = {};
%         index = 0;
%         for iprocessinglayer = itrajlayer.processing_layer
%            if ~isempty(iprocessinglayer.supertraj)
%                index  = index + 1;
%                estimators{index}= iprocessinglayer;
%            end
%         end
%         itrajlayer.aviable_estimators = estimators;
%     end
%     
%     %% Update Estimator Avialabel 
%     panel_estimator_aviable = findobj_figure(h.iur_figure,'tabgroup','Methods Comparison','Estimators Available');
%     delete(panel_estimator_aviable.Children)
%     
%     index = 1;
%     jList = java.util.ArrayList;  % any java.util.List will be ok
% 
%     aviable_estimators = {};
%     
%     
%     for iprosslayer = h.trajectory_layer(index_straj).processing_layer
%         if ~isempty(iprosslayer.mt)
%             jList.add(index-1,iprosslayer.label);
%             aviable_estimators{index} = iprosslayer;
%             index = index + 1;
%             
%         end
%     end
%     if isempty(aviable_estimators)
%       %errd = errordlg('You don''t have any estimation','','modal');
%       %waitfor(errd)
%       %h.iur_figure.Children(1).SelectedTab = h.iur_figure.Children(1).Children(4);
%       %init_signal_processing(object,event,h)
%       %return
%    end
    
%     h.trajectory_layer(index_straj).aviable_estimators = aviable_estimators;
%     
%     jCBList = com.mathworks.mwswing.checkboxlist.CheckBoxList(jList);
%     jScrollPane = com.mathworks.mwswing.MJScrollPane(jCBList);
%     [jhCBList,hContainer] = javacomponent(jScrollPane,[10,10,80,65],panel_estimator_aviable);
%     hContainer.Units = 'normalized';
%     hContainer.Position = [0.1 0.1 0.8 0.8];
%     hContainer.Tag = 'listbox';
%     set(jScrollPane,'MouseClickedCallback',{@estimator_available_callback,h})
%     h.javacomponets.comparison_layer.list_estimators.object = jCBList;


traj_layers = zeros(0,0,'trajectory_layer');
idx_traj = 0;
for itraj_layer = h.trajectory_layer
    estimators = zeros(0,0,'processing_layer');
    idx_esti = 0;
    for iprosslayer = itraj_layer.processing_layer
        if ~isempty(iprosslayer.mt)
            idx_esti = idx_esti + 1;
            estimators(idx_esti) =  iprosslayer;
        end
    end
    if ~isempty(estimators)
        idx_traj = idx_traj + 1;
        traj_layers(idx_traj) = itraj_layer;
        traj_layers(idx_traj).aviable_estimators = estimators;
    end
end


if isempty(traj_layers)
    er = errordlg('You don''t have any estimation!.','','modal');
    waitfor(er)
    h.iur_figure.Children(1).SelectedTab = h.iur_figure.Children(1).Children(4);
    init_signal_processing(object,event,h)
    return
end
%%
h.AvailableTraj = traj_layers;


listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Methods Comparison','Supertraj','listbox');
listbox_straj.Value = 1;
listbox_straj.String =  {h.AvailableTraj.label};



update_method_comparison(h)
