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
    %%
    panel_footmodel    = uipanel(panel_control,'Title','Foot Models Simulation'   ,'Position',[0.05 0.05 0.65 0.9],'Tag','Levels','Tag','Foot Models Simulation');
        %% By Floor

        uicontrol('style','text','Parent',panel_footmodel,'Units','normalized','Position',[0.005 0.1 0.1 0.8],'String','By Floor:')
        uicontrol('style','listbox','Parent',panel_footmodel,'Units','normalized','Position',[0.09 0.1 0.175 0.8],'Tag','listbox','Tag','By Floor:','Callback',{@openfile_listbox,h})
        %
        h.javacomponets.trajectory_layer.addbyFloor    = add_btn('Parent',panel_footmodel, ...
                                                            'Position',[0.275 0.6 0.025 0.3], ...
                                                            'Callback',{@addFcnlistbox,h}, ...
                                                            'Tag','addbyFloor');
        h.javacomponets.trajectory_layer.minusbyFloor    = minus_btn('Parent',panel_footmodel, ...
                                                            'Position',[0.275 0.2 0.025 0.3], ...
                                                            'Callback',{@minusFcnlistbox,h}, ...
                                                            'Tag','minusbyFloor');
                                                        
        %% By Elevator
        uicontrol('style','text','Parent',panel_footmodel,'Units','normalized','Position',[0.33 0.1 0.1 0.8],'String','By Elevator:')
        uicontrol('style','listbox','Parent',panel_footmodel,'Units','normalized','Position',[0.43 0.1 0.2 0.8],'Tag','listbox','Tag','By Elevator:','Callback',{@openfile_listbox,h})
        h.javacomponets.trajectory_layer.addbyElevator   = add_btn('Parent',panel_footmodel, ...
                                                            'Position',[0.635 0.6 0.025 0.3], ...
                                                            'Callback',{@addFcnlistbox,h}, ...
                                                            'Tag','addbyElevator');
        h.javacomponets.trajectory_layer.minusbyElevator   = minus_btn('Parent',panel_footmodel, ...
                                                            'Position',[0.635 0.2 0.025 0.3], ...
                                                            'Callback',{@minusFcnlistbox,h}, ...
                                                            'Tag','minusbyElevator');        
        %% By Stairs
        uicontrol('style','text','Parent',panel_footmodel,'Units','normalized','Position',[0.66 0.1 0.1 0.8],'String','By Stairs:')
        uicontrol('style','listbox','Parent',panel_footmodel,'Units','normalized','Position',[0.75 0.1 0.2 0.8],'Tag','listbox','Tag','By Stairs:','Callback',{@openfile_listbox,h})
        h.javacomponets.trajectory_layer.addbyStairs    = add_btn('Parent',panel_footmodel, ...
                                                            'Position',[0.96 0.6 0.025 0.3], ...
                                                            'Callback',{@addFcnlistbox,h}, ...
                                                            'Tag','addbyStairs');
        h.javacomponets.trajectory_layer.minusbyStairs    = minus_btn('Parent',panel_footmodel, ...
                                                            'Position',[0.96 0.2 0.025 0.3], ...
                                                            'Callback',{@minusFcnlistbox,h}, ...
                                                            'Tag','minusbyStairs');
    %%                                                    
    panel_foot2ref    = uipanel(panel_control,'Title','Foot To Reference trajectory'   ,'Position',[0.7 0.05 0.175 0.9],'Tag','Levels','Tag','Foot To Reference trajectory');

            uicontrol('style','listbox','Parent',panel_foot2ref,'Units','normalized','Position',[0.05 0.1 0.75 0.8],'Tag','listbox','Callback',{@openfile_listbox,h})

            h.javacomponets.trajectory_layer.addbyFloor    = add_btn('Parent',panel_foot2ref, ...
                                                            'Position',[0.85 0.6 0.1 0.3], ...
                                                            'Callback',{@addFcnlistbox,h}, ...
                                                            'Tag','addFoot2Ref');
            h.javacomponets.trajectory_layer.addbyFloor    = minus_btn('Parent',panel_foot2ref, ...
                                                            'Position',[0.85 0.2 0.1 0.3], ...
                                                            'Callback',{@minusFcnlistbox,h}, ...
                                                            'Tag','minusFoot2Ref');
                                                        
                                                        
    %%
    h.javacomponets.trajectory_layer.update_trajectory_models    = update_btn('Parent',panel_control, ...
                                                            'Position',[0.8825 0.3 0.025 0.4], ...
                                                            'Callback',{@update_trajectory_fcn,h}, ...
                                                            'Tag','addFoot2Ref');
                                                        
    %%
    btn_create_trajectory = uicontrol('style','pushbutton','Units','normalized','Position',[0.91 0.25 0.08 0.5],'Parent',panel_control,'String','Generate!','Callback',{@btn_generate_trajectory,h});
end


