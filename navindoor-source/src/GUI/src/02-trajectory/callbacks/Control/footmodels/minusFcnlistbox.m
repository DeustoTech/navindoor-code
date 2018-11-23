function minusFcnlistbox(object,event,h)
%MINUSFCNFLOOR Summary of this function goes here
%   Detailed explanation goes here
    
     
    switch object.get.MatlabHGContainer.get.Tag
        case 'minusbyStairs' 
            listbox = findobj_figure(h.iur_figure,'Trajectory','Foot Models Simulation','By Stairs:');
            path = 'WorkFolder/Models-Trajectory-Simulation/foot_velocity/byStairs/';
        case 'minusbyElevator'
            listbox = findobj_figure(h.iur_figure,'Trajectory','Foot Models Simulation','By Elevator:');
            path = 'WorkFolder/Models-Trajectory-Simulation/foot_velocity/byElevator/';
        case 'minusbyFloor'
            listbox = findobj_figure(h.iur_figure,'Trajectory','Foot Models Simulation','By Floor:');
            path = 'WorkFolder/Models-Trajectory-Simulation/foot_velocity/byFloor/';
        case 'minusFoot2Ref'
            listbox = findobj_figure(h.iur_figure,'Trajectory','Foot To Reference trajectory','listbox');
            path = 'WorkFolder/Models-Trajectory-Simulation/foot2Ref/';
        case 'minusFcnBeacons'
            listbox = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Event2msFcn:');
            type_pop = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','popupmenu');
            type = type_pop.String{type_pop.Value};
            path = ['WorkFolder/Models-Signal-Simulation/BeaconSgn/',type,'/'];
        case 'minusFcnFree'
            listbox = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','Event2msFcn:');
            type_pop = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','popupmenu');
            type = type_pop.String{type_pop.Value};
            path = ['WorkFolder/Models-Signal-Simulation/FreeSgn/',type,'/'];
    end


    file =  listbox.String{listbox.Value};
    
    if ismember(file,{  'foot2Ref_default.m',           ...
                        'byElevators_default.m',        ...
                        'byFloor_default.m',            ...
                        'Event2RSS_default.m',          ...
                        'Event2AoA_default.m',          ...
                        'Event2ToF_default.m',          ...
                        'Event2Barometer_default.m'     ...
                        'Event2InertialCoM_default.m'   ...
                        'Event2InertialFoot_default.m'  ...
                        'Event2Magnetometer_default.m', ...
                        'byStairs_default.m'})
       errordlg('This file is a default model, It can''t be delete. ') 
       return
    end
    result = questdlg(['Do you want remove ',file,'?']);
    if strcmp(result,'Yes')                 
        delete([path,file]);
        listbox.Value = 1;
        update_signal_layer(h)
        update_trajectory_fcn(object,event,h)
        update_processing_layer(h)
    end
end

