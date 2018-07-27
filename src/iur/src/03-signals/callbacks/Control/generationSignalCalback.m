function generationSignalCalback(object,event,h)
%GENERATIONSIGNALCALBACK Summary of this function goes here
%   Detailed explanation goes here
 

%% Apagar Generate:
edit_generate = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Info Objects','Generate:');
edit_generate.BackgroundColor =[1 0 0];
edit_generate.String ='FALSE';
pause(0.5)
%
ibuild = h.planimetry_layer(1).build;
%
listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
index_straj = listbox_straj.Value;
istraj = h.trajectory_layer(index_straj).supertraj;
% 
listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');
index_signals = listbox_signals.Value;



tab  = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Control','Tab');
tab = tab.SelectedTab;
popup = findobj_figure(tab,'popupmenu');
type = popup.String{popup.Value};

if istraj.dt == 0
   errordlg('The selected supertraj do not have velocity. Please return to Trayectory Panel and generate a velocity.') 
   return
end

switch tab.Title
    case  'Beacon Based'
       h.trajectory_layer(index_straj).signal_layer(index_signals).signal =  BeaconBasedSgn(istraj,ibuild,type);
    case 'Beacon Free'
       h.trajectory_layer(index_straj).signal_layer(index_signals).signal = BeaconFreeSgn(istraj,ibuild,type);
end

editlabel =findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Info Objects','Label:');
h.trajectory_layer(index_straj).signal_layer(index_signals).signal.label = editlabel.String;
h.trajectory_layer(index_straj).signal_layer(index_signals).label = editlabel.String;


update_signal_layer(h)



end

