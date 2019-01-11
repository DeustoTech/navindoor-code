function generationSignalCalback(object,event,h)
%GENERATIONSIGNALCALBACK Summary of this function goes here
%   Detailed explanation goes here
    %%
    listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
    index_straj = listbox_straj.Value;
    itraj = h.AvailableTraj(index_straj).traj;

    if isempty(itraj)
       errordlg('You must generete a trajectory!','Error','modal') 
       return
    end
    %%

    %% Apagar Generate:
%    edit_generate = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Info Objects','Generate:');
%    edit_generate.BackgroundColor =[1 1 0];
%    edit_generate.String ='Waiting ...';
    pause(0.5)
    %
    ibuilding = h.planimetry_layer(1).building;
    beacons = [ibuilding.levels.beacons];


    % 
    listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');
    index_signals = listbox_signals.Value;



    tab  = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Control','Tab');
    tab = tab.SelectedTab;
    popup = findobj_figure(tab,'popupmenu');
    type = popup.String{popup.Value};
    
    h.AvailableTraj(index_straj).signal_layer(index_signals).signal = [];
    
    set(h.iur_figure, 'pointer', 'watch')
    pause(0.1)
    try     
        switch tab.Title
            case  'Beacon Based'
               %
               if isempty(beacons)
                   error('There must be at least one beacon per floor')
               end
                edit_frecuency = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Frecuency:');
               frecuency = str2num(edit_frecuency.String);
               %
               listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Event2msFcn:');
               Event2msFcnGUI = str2func(listbox_Event2msFcn.String{listbox_Event2msFcn.Value}(1:(end-2)));
               Event2msFcnGUI_str = listbox_Event2msFcn.String{listbox_Event2msFcn.Value}(1:(end-2));
               h.AvailableTraj(index_straj).signal_layer(index_signals).signal =  BeaconSgn(itraj,type,beacons,'frecuency',frecuency,'Event2msFcn',Event2msFcnGUI);
            case 'Beacon Free'
               edit_frecuency = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','Frecuency:');
               %
               listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','Event2msFcn:');
               Event2msFcnGUI = str2func(listbox_Event2msFcn.String{listbox_Event2msFcn.Value}(1:(end-2)));
               Event2msFcnGUI_str = listbox_Event2msFcn.String{listbox_Event2msFcn.Value}(1:(end-2));
               %
               frecuency = str2num(edit_frecuency.String);
               h.AvailableTraj(index_straj).signal_layer(index_signals).signal = FreeSgn(itraj,type,'frecuency',frecuency,'Event2msFcn',Event2msFcnGUI);

        end
        editlabel =findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Info Objects','Label:');
        h.AvailableTraj(index_straj).signal_layer(index_signals).signal.label = h.AvailableTraj(index_straj).signal_layer(index_signals).label;
        
        h.AvailableTraj(index_straj).signal_layer(index_signals).type = type;
        h.AvailableTraj(index_straj).signal_layer(index_signals).frecuency = frecuency;
        h.AvailableTraj(index_straj).signal_layer(index_signals).beacons = beacons;
        h.AvailableTraj(index_straj).signal_layer(index_signals).Event2msFcn = Event2msFcnGUI_str;
        set(h.iur_figure, 'pointer', 'arrow')

    catch err
        set(h.iur_figure, 'pointer', 'arrow')
        errordlg(err.message)  
    end

    
    update_signal_layer(h)


end

