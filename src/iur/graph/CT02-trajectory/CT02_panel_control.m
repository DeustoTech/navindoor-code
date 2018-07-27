function CT02_panel_control(h,panel_control)
%CT02_PANEL_CONTROL Summary of this function goes here
%   Detailed explanation goes here

    %% Levels
    panel_levels    = uipanel(panel_control,'Title','Levels'   ,'Position',[0.0 0.05 0.05 0.9],'Tag','Levels');

    uicontrol('style','listbox', 'Parent',panel_levels,    ...
              'String','0',                                ...
              'Units','normalized',                        ... 
              'Position',[0.1 0.1 0.7 0.8],                ...
              'Callback',{@listbox_trajectoryCallback,h},  ...
              'Tag','listbox');

          
    %% Velocity                                              
    panel_velocity = uipanel(panel_control,'Title','Velocity'   ,'Position',[0.05 0.05 0.945 0.9],'Tag','Velocity');
    
             % text Velocity model
             uicontrol('style','text','Parent',panel_velocity,    ...
                       'String','Velocity model',                 ...
                       'Units','normalized',                      ...
                       'Position',[0.0150 0.500 0.1500 0.3000]);   
             % popupmenu of velocity models 
             popmenu_model = uicontrol('style','popupmenu','Parent',panel_velocity,  ...
                       'Units','normalized',                         ...
                       'Position',[0.00500  0.1500  0.175  0.3000],               ...
                       'Tag','velocity model');    
                                             
            panel_parameter_model = uipanel(panel_velocity,'Title','Paremeters Model',               ...
                                                           'Position',[0.20 0.0500 0.62500 0.9500],  ...
                                                           'Tag','Paremeters Model');
                                                       
              % load the several velocity models 
             
             velocity_models(panel_parameter_model,popmenu_model)
       
             % Add Velocity
             uicontrol('style','pushbutton','Parent',panel_velocity,       ...
                       'String','Add Velocity',                            ...
                       'Units','normalized',                               ...
                       'Position',[0.835 0.2 0.080 0.5],                   ...
                       'Tag','Add Velocity',                               ...
                       'Callback',{@btn_add_velocityCallback,h});
                                                  
             % Animation                                     
             uicontrol('style','pushbutton','Parent',panel_velocity,    ...
                                      'String','Animation',             ...
                                      'Units','normalized',             ...
                                      'Position',[0.92 0.2 0.07 0.5], ...
                                      'Tag','Animation',                ...
                                      'Callback',{@btn_animationCallback,h});
end


