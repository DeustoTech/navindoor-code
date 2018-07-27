function update_signal_layer(h)
%UPDATE_TRAJECTORY_LAYER Summary of this function goes here
%   Detailed explanation goes here

%% index Supertraj
listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
index_straj = listbox_supertraj.Value;
    
 %% Signal   
listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');

listbox_signals.String =  {h.trajectory_layer(index_straj).signal_layer.label};
index_signals = listbox_signals.Value;
signal = h.trajectory_layer(index_straj).signal_layer(index_signals).signal;
%% Info Objects

panel_info = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Info Objects');
generate_signal = findobj_figure(panel_info,'Generate:');
label_signal = findobj_figure(panel_info,'Label:');

% Generate:
if isempty(signal)
    generate_signal.String = 'FALSE';
    generate_signal.BackgroundColor = [1 0 0];    
    % Label;
    label_signal.String = h.trajectory_layer(index_straj).signal_layer(index_signals).label;
    % Graph
    panel_graphs = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Graphs');
    delete(panel_graphs.Children);
    return
else
    generate_signal.BackgroundColor = [0 1 0.5];
    generate_signal.String = 'TRUE';
end
% Parent
parent_signal.String = signal.supertraj.label;
% Label;
label_signal.String = signal.label;


%% Control

tab = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Control','Tab');
switch class(signal)
    case 'BeaconBasedSgn'
        tab.SelectedTab = tab.Children(1);
        popup = findobj_figure(tab,'Beacon Based','popupmenu');
        switch signal.type
            case 'RSS'
               popup.Value = 1; 
            case 'ToF'
               popup.Value = 2; 
            case 'AoA'
               popup.Value = 3; 
        end
    case 'BeaconFreeSgn'
        tab.SelectedTab = tab.Children(2);
        popup = findobj_figure(tab,'Beacon Free','popupmenu');
        switch signal.type
            case 'Baro'
               popup.Value = 1; 
            case 'Gyro'
               popup.Value = 2; 
            case 'Acel'
               popup.Value = 3;
            case 'Magne'
               popup.Value = 4;
        end
end
%% Graphs 
panel_graphs = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Graphs');
delete(panel_graphs.Children);

listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');
index_signals = listbox_signals.Value;
plot(h.trajectory_layer(index_straj).signal_layer(index_signals).signal,'Parent',panel_graphs) ;

label_signal = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Info Objects','Label:');
label_signal.String = h.trajectory_layer(index_straj).signal_layer(index_signals).label;



    
%% 

end

