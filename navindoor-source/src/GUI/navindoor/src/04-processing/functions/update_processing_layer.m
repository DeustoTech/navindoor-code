function update_processing_layer(h,varargin)
%UPDATE_TRAJECTORY_LAYER Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    
    addRequired(p,'h')
    addOptional(p,'layer',true)
    
    parse(p,h,varargin{:})
    
    layer = p.Results.layer;
    
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
    

%%
    listbox_algorithms = findobj_figure(tab_signal_processing,'Algorithms','listbox');
    result = dir('WorkFolder/Tracking-Algorithms/');
    
    algorithms = {};
    for index = 1:length(result)
        name_main_file = what([result(index).folder,'/',result(index).name]);
        if length(name_main_file.m) == 1
            algorithms(index) = name_main_file.m;
        end
    end
    if ispc
        algorithms(1) = [];
        algorithms(1) = [];
    end
    
    listbox_algorithms.String = cellstr(algorithms);
    % si existe alguna estimacion seleccionamos la funcion con la que fue creada, 
    % solo cuando se llame la funcion con el parametro layer=true 
    if layer && ~isempty(h.trajectory_layer(index_straj).processing_layer(index_processing).mt)
        file = [func2str(h.trajectory_layer(index_straj).processing_layer(index_processing).AlgorithmFcn),'.m'];
        [~,indx] = ismember(file,algorithms);
        listbox_algorithms.Value = indx;
    end
    

%% Initial State
    
%     checkbox_by_default = findobj_figure(tab_signal_processing,'Initial State','By default');
%     edit_InitState = findobj_figure(tab_signal_processing,'InitialState');
%     
%     
%     if proc_layer.InitState_default
%         checkbox_by_default.Value = 1;
%         edit_InitState.Enable = 'off';
%         if ~isempty(traj_layer.traj)
%             
%             result = step(traj_layer.traj,0);
%             x     = [num2str(result.x,'%.2f'),' , '];
%             y     = [num2str(result.y,'%.2f'),' , '];
%             hight = [num2str(result.z,'%.2f'),' , '];
%             vx    = [num2str(result.vx,'%.2f'),' , '];
%             vy    = num2str(result.vy,'%.2f');
% 
%             edit_InitState.String = ['[',x,y,hight,vx,vy,']']; 
%         end
%     else
%         checkbox_by_default.Value = 0;
% 
%     end
    
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

    %%
    if layer && ~isempty(h.trajectory_layer(index_straj).processing_layer(index_processing).mt)
       jCBModel = jCBList.getCheckModel;
       %
       index = 0;
       for isignal = traj_layer.aviable_signals
            index = index + 1;
            if ismember(isignal{:},h.trajectory_layer(index_straj).processing_layer(index_processing).Signals)
                jCBModel.checkIndex(index-1)
            end
       end
    end
    %%
    h.javacomponets.processing_layer.list_signals.object = jCBList;

%% Info Objects 
    %
    edit_label = findobj_figure(h.iur_figure,'Signal Processing','Info Objects','Label:');
    edit_label.String = proc_layer.label;
    % 

    edit_generate = findobj_figure(h.iur_figure,'Signal Processing','Info Objects','Generate:');

    compute_estimator = ~isempty(h.trajectory_layer(index_straj).processing_layer(index_processing).mt);
    if compute_estimator
        edit_generate.BackgroundColor = [0 1 0.5]; 
        edit_generate.String = 'TRUE';
    else
        edit_generate.String = 'FALSE';
        edit_generate.BackgroundColor = [1 0 0]; 

    end
    

    %% Dibujar si existe estimador calculado
    % Graphs 
    panel_graphs = findobj_figure(h.iur_figure,'Signal Processing','Graphs');
    if isempty(panel_graphs.Children)
       axes('Parent',panel_graphs) 
    end
    
    if ~isempty(h.trajectory_layer(index_straj).processing_layer(index_processing).mt)
            
         mt = h.trajectory_layer(index_straj).processing_layer(index_processing).mt;
         
         panel_graphs  = findobj_figure(h.iur_figure,'Signal Processing','Graphs');
         delete(panel_graphs.Children)
         ax = axes('Parent',panel_graphs);
         plot(h.planimetry_layer,1,ax,'replot',true);

         plot(h.trajectory_layer,0,ax)
         line(mt(:,1),mt(:,2),'Parent',ax,'Color','Red')
         %
        
         
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

