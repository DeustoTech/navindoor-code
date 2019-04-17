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

    traj_layer = h.AvailableTraj(index_straj);
    proc_layer = h.AvailableTraj(index_straj).processing_layer(index_processing);
    

%%
    listbox_algorithms = findobj_figure(tab_signal_processing,'Control','listbox');
    result = dir(fullfile(h.navindoor_path,'WorkFolder','Tracking-Algorithms'));
    
    algorithms = {};
    index_algo = 0;
    for index = 1:length(result)
        name_main_file = what([result(index).folder,'/',result(index).name]);
        if length(name_main_file.m) == 1
            if ~isempty(name_main_file.m{:})
                index_algo = index_algo + 1;
                algorithms(index_algo) = name_main_file.m;
            end
        end
    end

    listbox_algorithms.String = cellstr(algorithms);
    % si existe alguna estimacion seleccionamos la funcion con la que fue creada, 
    % solo cuando se llame la funcion con el parametro layer=true 
    if layer && ~isempty(h.AvailableTraj(index_straj).processing_layer(index_processing).AlgorithmFcn)
        file = [func2str(h.AvailableTraj(index_straj).processing_layer(index_processing).AlgorithmFcn),'.m'];
        [~,indx] = ismember(file,algorithms);
        listbox_algorithms.Value = indx;
    end
    
%% Estimators Panel 
    listbox = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Estimators','listbox');
    
    index = 0;
    String = {};
    for ilabel = {traj_layer.processing_layer.label}
        index = index + 1;
        if isempty(traj_layer.processing_layer(index).mt)
            String{index} = ['<HTML><FONT color="FF0000">',ilabel{:},' - NONE </FONT></HTML>'];
        else 
            String{index} = ['<HTML><FONT color="2ecc39">',ilabel{:},' - OK </FONT></HTML>'];
        end
    end
    listbox.String = String;
                 
%% Aviable Signals
    
    panel_signal_aviable = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Signals Available');
    delete(panel_signal_aviable.Children)
    
    index = 1;
    jList = java.util.ArrayList;  % any java.util.List will be ok

    for isignal = traj_layer.aviable_signals
        if ~isempty(isignal)
            jList.add(['<HTML>',index-1,isignal.label,' - <FONT color="BLUE"> ',isignal.type,' </FONT></HTML>']);
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
    if layer && ~isempty(h.AvailableTraj(index_straj).processing_layer(index_processing).mt)
       jCBModel = jCBList.getCheckModel;
       %
       index = 0;
       for isignal = traj_layer.aviable_signals
            index = index + 1;
            if ismemberSignal(isignal.signal,h.AvailableTraj(index_straj).processing_layer(index_processing).Signals)
                jCBModel.checkIndex(index-1)
            end
       end
    end
    %%
    h.javacomponets.processing_layer.list_signals.object = jCBList;

    %% Dibujar si existe estimador calculado
    % Graphs 
    panel_graphs = findobj_figure(h.iur_figure,'Signal Processing','Graphs');
    if ~isempty(panel_graphs.Children)
        delete(panel_graphs.Children)
    end

    if ~isempty(h.AvailableTraj(index_straj).processing_layer(index_processing).mt)
            
%          mt = h.AvailableTraj(index_straj).processing_layer(index_processing).mt;
%          
%          panel_graphs  = findobj_figure(h.iur_figure,'Signal Processing','Graphs');
%          delete(panel_graphs.Children)
%          ax = axes('Parent',panel_graphs);
%          plot(h.planimetry_layer,1,ax,'replot',true);
% 
%          plot(h.AvailableTraj(index_straj),0,ax);
%          line(mt(:,1),mt(:,2),'Parent',ax,'Color','Red');
%          %
%          hline = zeros(2, 1);
%          hline(1) = line(NaN,NaN,'Parent',ax,'Color','Blue');
%          hline(2) = line(NaN,NaN,'Parent',ax,'Color','Red');
%          legend(hline, {'Real Trajectory','Estimate Trajectory'},'Location','NorthEastOutside');
%          
        GT_estimate = h.AvailableTraj(index_straj).processing_layer(index_processing).RefGT_estimate;
        GT_real = h.AvailableTraj(index_straj).traj.GroundTruths.Ref;
        
        GT_real.label = 'real';
        GT_estimate.label = 'estimation';

        imap = h.planimetry_layer(1).map;
        ax = axes('Parent',panel_graphs);
        delete(ax.Children)
        last([GT_estimate GT_real],'map',imap,'axes',ax)
        
    else
       delete(panel_graphs.Children)
    end
    
end


function boolean = ismemberSignal(isignal,signals)
%%
    boolean = false;
    for  jsignal = signals
        if strcmp(class(isignal),class(jsignal{:}))
            if strcmp(isignal.type ,jsignal{:}.type)
                if strcmp(isignal.label,jsignal{:}.label) && isignal.frecuency ==  jsignal{:}.frecuency 
                    boolean = true;
                    break
                end
            end
        end
    end
end
