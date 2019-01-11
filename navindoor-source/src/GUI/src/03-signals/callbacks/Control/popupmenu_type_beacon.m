function popupmenu_type_beacon(object,event,h)
%POPUPMENU_TYPE_BEACON Summary of this function goes here
%   Detailed explanation goes here

tab = findobj_figure(h.iur_figure,'Signal Generation');
switch object.Parent.Tag
    case 'Beacon Free'
        listbox = findobj_figure(tab,'Beacon Free','Event2msFcn:');
        listbox_type = findobj_figure(tab,'Beacon Free','popupmenu');
        type =  listbox_type.String{listbox_type.Value};
        listbox_Event2msFcn = findobj_figure(tab,'Beacon Free','Event2msFcn:');
        result =  what(['Models-Signal-Simulation/FreeSgn/',type]);
        listbox_Event2msFcn.String =result.m;
    case 'Beacon Based'
        listbox = findobj_figure(tab,'Beacon Based','Event2msFcn:');
        listbox_type = findobj_figure(tab,'Beacon Based','popupmenu');
        type =  listbox_type.String{listbox_type.Value};
        listbox_Event2msFcn = findobj_figure(tab,'Beacon Based','Event2msFcn:');
        result =  what(['Models-Signal-Simulation/BeaconSgn/',type]);
        listbox_Event2msFcn.String =result.m;
end
listbox.Value = 1;



%% 


end

