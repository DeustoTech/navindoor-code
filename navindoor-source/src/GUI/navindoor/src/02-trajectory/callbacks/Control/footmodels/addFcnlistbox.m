function addFcnlistbox(object,event,h)
%ADDFCNFLOOR Summary of this function goes here
%   Detailed explanation goes here
    
 prompt={'Enter the name of file ofyour new floor model'};
 name='Input for Peaks function';
 defaultanswer={'untitle.m'};    
 numlines = 1;
 
 
    switch object.get.MatlabHGContainer.get.Tag
        case 'addbyStairs' 
            path = 'WorkFolder/Models-Trajectory-Simulation/foot_velocity/byStairs/';
            file_template  = [path,'byStairs_default.m'];
        case 'addbyElevator'
            path = 'WorkFolder/Models-Trajectory-Simulation/foot_velocity/byElevator/';
            file_template  = [path,'byElevators_default.m'];
        case 'addbyFloor'
            path = 'WorkFolder/Models-Trajectory-Simulation/foot_velocity/byFloor/';
            file_template  = [path,'byFloor_default.m'];
        case 'addFoot2Ref'
            path = 'WorkFolder/Models-Trajectory-Simulation/foot2Ref/';
            file_template  = [path,'foot2Ref_default.m'];
        case 'addFcnBeacons'
            type_pop = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','popupmenu');
            type = type_pop.String{type_pop.Value};
            path = ['WorkFolder/Models-Signal-Simulation/BeaconSgn/',type,'/'];
            file_template = [path,'Event2',type,'_default.m'];
        case 'addFcnFree'
            type_pop = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','popupmenu');
            type = type_pop.String{type_pop.Value};
            path = ['WorkFolder/Models-Signal-Simulation/FreeSgn/',type,'/'];
            file_template = [path,'Event2',type,'_default.m'];
        case 'addAlgorithms'
            path = 'WorkFolder/Tracking-Algorithms/';
            file_template = [path,'EKF/ekf_prueba.m'];
    end
    answer=inputdlg(prompt,name,numlines,defaultanswer);
    
    
    if exist(answer{:},'file') == 2
       errordlg('Ya existe una funcion con ese nombre, para evitar confuciones elije otro nombre') 
       return
    end
    

    
    try      
        if strcmp(object.get.MatlabHGContainer.get.Tag,'addAlgorithms')||strcmp(object.get.MatlabHGContainer.get.Tag,'minusAlgorithms')
           mkdir([path,answer{:}(1:(end-2))])
           copyfile(file_template,[path,answer{:}(1:(end-2)),'/',answer{:}])
           addpath([path,answer{:}(1:(end-2))])
        else
           copyfile(file_template,[path,answer{:}])
        end
    catch err
       errordlg(err.message) 
    end
    
    switch object.get.MatlabHGContainer.get.Tag
        case 'addbyStairs' 
            update_trajectory_fcn(object,event,h)
        case 'addbyElevator'
            update_trajectory_fcn(object,event,h)
        case 'addbyFloor'
            update_trajectory_fcn(object,event,h)
        case 'addFoot2Ref'
            update_trajectory_fcn(object,event,h)
        case 'addFcnBeacons'
            update_signal_layer(h)
        case 'addFcnFree'
            update_signal_layer(h)
        case 'addAlgorithms'
            update_processing_layer(h)
    end
    

end

