function btn_add_velocityCallback(object,event,h)
%BTN_ADD_VELOCITYCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    

    mu       = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Velocity','Paremeters Model','mu');
    mu = str2double(mu.String);
    
    sigma    = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Velocity','Paremeters Model','sigma');
    sigma = str2double(sigma.String);

    k        = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Velocity','Paremeters Model','k');
    k = str2double(k.String);

    lambda   = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Velocity','Paremeters Model','lambda');
    lambda = str2double(lambda.String);

    sections = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Velocity','Paremeters Model','sections');
    sections = str2double(sections.String);

    
    listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
    index_straj = listbox_straj.Value;
    
    if isempty(h.trajectory_layer(index_straj).vertexs)
       errordlg('Can not be create a velocity, in empty supertraj. Please add vertex, by cliking .') 
       return
    end
    
    
    ibuild = h.planimetry_layer.build;
    
    h.trajectory_layer(index_straj).supertraj = velocity(h.trajectory_layer(index_straj).supertraj,ibuild,'sections',sections,'mu',mu,'sigma',sigma,'k',k,'lambda',lambda,'waitbar',true);

    %% Si se agrega una nuevva velocidad, es necesario eliminar las señales previas 
    len =length(h.trajectory_layer(index_straj).signal_layer);
    for index = 1:len
        h.trajectory_layer(index_straj).signal_layer(index).signal = [];
    end
    
    update_trajectory_layer(h)
end

