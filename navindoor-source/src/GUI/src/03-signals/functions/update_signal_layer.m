function update_signal_layer(h,varargin)
%UPDATE_TRAJECTORY_LAYER Summary of this function goes here
%   Detailed explanation goes here
p = inputParser;

addRequired(p,'h')
addOptional(p,'layer',false)
addOptional(p,'onlyaddsignal',false)

parse(p,h,varargin{:})

layer = p.Results.layer;
onlyaddsignal = p.Results.onlyaddsignal;


%% index Supertraj
listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
index_straj = listbox_supertraj.Value;
    
 %% Signal   
listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');

String = {};
index = 0;
for ilabel = {h.AvailableTraj(index_straj).signal_layer.label}
    index = index + 1;
    if ~isempty(h.AvailableTraj(index_straj).signal_layer(index).signal)
        String{index} = ['<HTML><FONT color="2ecc39">',ilabel{:},' - OK </FONT></HTML>'];
    else
        String{index} = ['<HTML><FONT color="FF0000">',ilabel{:},' - NONE </FONT></HTML>'];
    end
end
listbox_signals.String =  String;


index_signals = listbox_signals.Value;

siglayer = h.AvailableTraj(index_straj).signal_layer(index_signals);

%%
if layer && ~isempty(siglayer.type)
   tabsignal = findobj_figure(h.iur_figure,'Signal Generation','Control','Tab');
   
   switch class(siglayer.signal)
        case 'BeaconSgn'
            
            listbox_type = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','popupmenu');
             
            %listbox_type.String{listbox_type.Value} = siglayer.signal.type;
            switch siglayer.signal.type
                case 'RSS'
                    listbox_type.Value = 1;
                case 'ToF'
                    listbox_type.Value = 2;
                case 'AoA'
                    listbox_type.Value = 3;
            end
            
            type =  siglayer.signal.type;
            
            listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Event2msFcn:');
            result =  what(['Models-Signal-Simulation/BeaconSgn/',type]);
            listbox_Event2msFcn.String =result.m;

            tabsignal.SelectedTab = tabsignal.Children(1);
            listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Event2msFcn:');
            [~ , index ] = ismember([siglayer.Event2msFcn,'.m'],listbox_Event2msFcn.String);
            listbox_Event2msFcn.Value = index;
            %
            edit_frecuency = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Frecuency:');
            edit_frecuency.String = num2str(siglayer.frecuency);
        case 'FreeSgn'
            %% 
            listbox_type = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','popupmenu');
            
            listbox_type.String{listbox_type.Value} = siglayer.signal.type;

            type =  listbox_type.String{listbox_type.Value};

            listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','Event2msFcn:');
            result =  what(['Models-Signal-Simulation/FreeSgn/',type]);
            listbox_Event2msFcn.String =result.m;

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

%panel_info = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Info Objects');
%generate_signal = findobj_figure(panel_info,'Generate:');
%label_signal = findobj_figure(panel_info,'Label:');

% Generate:
% if isempty(signal)
%     generate_signal.String = 'FALSE';
%     generate_signal.BackgroundColor = [1 0 0];    
%     % Label;
%     label_signal.String = h.AvailableTraj(index_straj).signal_layer(index_signals).label;
%     % Graph
%     panel_graphs = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Graphs');
%     delete(panel_graphs.Children);
%     return
% else
%     generate_signal.BackgroundColor = [0 1 0.5];
%     generate_signal.String = 'TRUE';
% end
% Label;
%label_signal.String = signal.label;


%% Control

panel_graphs = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Graphs');
delete(panel_graphs.Children);
%% Graphs 
if ~isempty(h.AvailableTraj(index_straj).signal_layer(index_signals).signal)

    listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');
    index_signals = listbox_signals.Value;
    plot(h.AvailableTraj(index_straj).signal_layer(index_signals).signal,'Parent',panel_graphs) ;

end
 
end

