function update_processing_layer(h)
%UPDATE_TRAJECTORY_LAYER Summary of this function goes here
%   Detailed explanation goes here
%% Tab Signal Processing
    tab_signal_processing = findobj_figure(h.iur_figure,'tabgroup','Signal Processing');
%% Indexs 
    % supertraj
    listbox_supertraj = findobj_figure(tab_signal_processing,'Supertraj','listbox');
    index_straj = listbox_supertraj.Value;
    % estimators
    listbox_estimators = findobj_figure(tab_signal_processing,'Estimators','listbox');
    index_processing  = listbox_estimators.Value;

    traj_layer = h.trajectory_layer(index_straj);
    proc_layer = h.trajectory_layer(index_straj).processing_layer(index_processing);
%% Initial State
    
    checkbox_by_default = findobj_figure(tab_signal_processing,'Initial State','By default');
    edit_InitState = findobj_figure(tab_signal_processing,'InitialState');
    
    
    if proc_layer.InitState_default
        checkbox_by_default.Value = 1;
        edit_InitState.Enable = 'off';
        if traj_layer.supertraj.dt ~= 0
            
            result = step(traj_layer.supertraj,0,'all',true);
            x     = [num2str(result.x,'%.2f'),' , '];
            y     = [num2str(result.y,'%.2f'),' , '];
            hight = [num2str(result.h,'%.2f'),' , '];
            vx    = [num2str(result.vx,'%.2f'),' , '];
            vy    = num2str(result.vy,'%.2f');

            edit_InitState.String = ['[',x,y,hight,vx,vy,']']; 
        end
    else
        checkbox_by_default.Value = 0;
        edit_InitState.Enable = 'on';

        
    end
    
%% Estimators Panel 
    listbox = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Estimators','listbox');
    listbox.String = {traj_layer.processing_layer.label};
                 
%% Aviable Signals
    
    panel_signal_aviable = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Signals Available');
    delete(panel_signal_aviable.Children)
    
    index = 1;
    jList = java.util.ArrayList;  % any java.util.List will be ok

    for isignal = traj_layer.aviable_signals
        if ~isempty(isignal)
            jList.add(index-1,isignal{:}.label);
            index = index + 1;
        end
    end
    
    jCBList = com.mathworks.mwswing.checkboxlist.CheckBoxList(jList);
    jScrollPane = com.mathworks.mwswing.MJScrollPane(jCBList);
    [jhCBList,hContainer] = javacomponent(jScrollPane,[10,10,80,65],panel_signal_aviable);
    hContainer.Units = 'normalized';
    hContainer.Position = [0.1 0.1 0.8 0.8];
    hContainer.Tag = 'listbox';

    h.javacomponets.processing_layer.list_signals.object = jCBList;

%% Info Objects 
    %
    edit_label = findobj_figure(h.iur_figure,'Signal Processing','Info Objects','Label:');
    edit_label.String = proc_layer.label;
    % 

    edit_generate = findobj_figure(h.iur_figure,'Signal Processing','Info Objects','Generate:');

    compute_estimator = ~isempty(proc_layer.error);
    if compute_estimator
        edit_generate.BackgroundColor = [0 1 0.5]; 
        edit_generate.String = 'TRUE';
    else
        edit_generate.String = 'FALSE';
        edit_generate.BackgroundColor = [1 0 0]; 

    end
    
    %% Seleccionar Signal Available, si existe estimator calculado
    if compute_estimator
        label_straj = proc_layer.estimator.estimation.label;
        index = 0;
        for ilabel_straj = listbox_supertraj.String'
            index = index + 1;
            if strcmp(ilabel_straj{:},label_straj)
                listbox_supertraj.Value = index;
                break
            end
        end
        % Select Signals of estimators
        index = 0;
        jCBModel = jCBList.getCheckModel;
        for label_signal = char(jList.toArray)'
            index = index + 1;
            for isignal = proc_layer.estimator.signals
                if strcmp(label_signal',isignal{:}.label)
                    jCBModel.checkIndex(index-1);
                    break
                end
            end
        end
    end
    %% Dibujar si existe estimador calculado
    % Graphs 
    panel_graphs = findobj_figure(h.iur_figure,'Signal Processing','Graphs');
    if isempty(panel_graphs.Children)
       axes('Parent',panel_graphs) 
    end
    
    if compute_estimator

         %
         A = h.trajectory_layer(index_straj).processing_layer(index_processing).ecdf.A;
         B = h.trajectory_layer(index_straj).processing_layer(index_processing).ecdf.B;
         %
         [~,index_min] =min(abs(A-0.9));
         %
         plot(B,A,'Parent',panel_graphs.Children)
         panel_graphs.Children.Title.String = ['90 % - - - ',num2str(B(index_min)),'m'];
         panel_graphs.Children.XLabel.String = 'time(s)';
         panel_graphs.Children.YLabel.String = 'Error(m)';
         panel_graphs.Children.XGrid = 'on';
         panel_graphs.Children.YGrid = 'on';
         panel_graphs.Children.Tag = 'axes';
    else
       delete(panel_graphs.Children)
    end
    
    btn_animation = findobj_figure(h.iur_figure,'Signal Processing','Control','Animation');
    if compute_estimator
        btn_animation.Enable = 'on';
    else
        btn_animation.Enable = 'off';
    end
        
end

