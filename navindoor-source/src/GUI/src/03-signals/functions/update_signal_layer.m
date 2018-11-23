function update_signal_layer(h,varargin)
%UPDATE_TRAJECTORY_LAYER Summary of this function goes here
%   Detailed explanation goes here
p = inputParser;

addRequired(p,'h')
addOptional(p,'layer',false)

parse(p,h,varargin{:})

layer = p.Results.layer;
%% 

%% 
listbox_type = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','popupmenu');
type =  listbox_type.String{listbox_type.Value};
listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Event2msFcn:');
result =  what(['Models-Signal-Simulation/BeaconSgn/',type]);
listbox_Event2msFcn.String =result.m;

%% 
listbox_type = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','popupmenu');
type =  listbox_type.String{listbox_type.Value};
listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','Event2msFcn:');
result =  what(['Models-Signal-Simulation/FreeSgn/',type]);
listbox_Event2msFcn.String =result.m;
%%

%% index Supertraj
listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
index_straj = listbox_supertraj.Value;
    
 %% Signal   
listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');

listbox_signals.String =  {h.trajectory_layer(index_straj).signal_layer.label};
index_signals = listbox_signals.Value;
signal = h.trajectory_layer(index_straj).signal_layer(index_signals).signal;

siglayer = h.trajectory_layer(index_straj).signal_layer(index_signals);

%%
if layer && ~isempty(siglayer.type)
   tabsignal = findobj_figure(h.iur_figure,'Signal Generation','Control','Tab');
   
   switch class(siglayer.signal)
        case 'BeaconSgn'
            tabsignal.SelectedTab = tabsignal.Children(1);
            listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Event2msFcn:');
            [~ , index ] = ismember([siglayer.Event2msFcn,'.m'],listbox_Event2msFcn.String);
            listbox_Event2msFcn.Value = index;
            %
            edit_frecuency = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Frecuency:');
            edit_frecuency.String = num2str(siglayer.frecuency);
        case 'FreeSgn'
            tabsignal.SelectedTab = tabsignal.Children(2);
            listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','Event2msFcn:');
            [~ , index ] = ismember([siglayer.Event2msFcn,'.m'],listbox_Event2msFcn.String);
            listbox_Event2msFcn.Value = index;
            %
            edit_frecuency = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','Frecuency:');
            edit_frecuency.String = num2str(siglayer.frecuency);
    end
end


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
% Label;
label_signal.String = signal.label;


%% Control

tab = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Control','Tab');

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

