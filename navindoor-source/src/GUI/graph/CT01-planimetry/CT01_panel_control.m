function CT01_panel_control(h,panel_control)
%CT01_PANEL_CONTROL Summary of this function goes here
%   Detailed explanation goes here

import javax.swing.*


%% Panel Title: Levels
panel_levels    = uipanel(panel_control,'Title','Levels'   ,'Position',[0.0 0.00 0.25 1],'Tag','Levels');

    listbox_levels     = uicontrol('style','listbox',    'Parent',panel_levels,    ...
                                                         'String','0',             ...
                                                         'Units','normalized',     ... 
                                                         'Position',[0.05 0.1 0.155 0.8], ...
                                                         'Callback',{@listbox_planimetryCallback,h}, ...
                                                         'Tag','listbox');
    
    button_add_level   = uicontrol('style','pushbutton','Parent',panel_levels, ...
                                                        'FontSize',15,         ...
                                                        'String','+',          ...
                                                        'Units','normalized',  ...
                                                        'Position',[0.25 0.5 0.08 0.3], ...
                                                        'Callback',{@btn_addCallback,h}, ...
                                                        'Tag','add');
                                                    
    button_minus_level = uicontrol('style','pushbutton','Parent',panel_levels, ...
                                                        'FontSize',15,         ...
                                                        'String','-',          ...
                                                        'Units','normalized',  ...
                                                        'Position',[0.25 0.2 0.08 0.3], ...
                                                        'Callback',{@btn_minusCallback,h}, ...
                                                        'Tag','minus');

                                                    
    text_hieght = uicontrol('style','text','Parent',panel_levels, ...
                                           'String','Height',     ...
                                           'Units','normalized',  ...
                                           'Position',[0.45 0.55 0.15 0.3]);
                                       
    edit_hieght = uicontrol('style','edit','Parent',panel_levels,              ...
                                           'String','0',                       ...
                                           'Units','normalized',               ...
                                           'Position',[0.45 0.25 0.15 0.3],       ...
                                           'Callback',{@edit_hieghtCallback,h}, ...
                                           'Tag','Height');
                                       
                                       
    view_button        = uicontrol('style','pushbutton','Parent',panel_levels, ...
                                                        'String','Building 3D',      ...
                                                        'Units','normalized',  ...
                                                        'Position',[0.7 0.2 0.25 0.6], ...
                                                        'Callback',{@btn_viewCallback,h}, ...
                                                        'Tag','view');
                                                    
%% Panel Title: PNG File
panel_png = uipanel(panel_control,'Title','PNG File' ,'Units','normalized','Position',[0.25 0.00 0.4 1.0],'Tag','PNG File');

    edit_label          = uicontrol('style','edit','String',' ','Parent',panel_png,'Tag','path');
    edit_label.Units       = 'normalized';
    edit_label.Position    = [0.05 0.25 0.55 0.5];

    btn_load_png = uicontrol('style','pushbutton','String','load',                  ...
                                                  'Parent',panel_png,               ...
                                                  'Units','normalized',             ...
                                                  'Position',[0.65 0.55 0.15 0.35],    ...
                                                  'Callback',{@btn_loadCallback,h}, ...
                                                  'Tag','btnload');
                                              
    btn_remove_png = uicontrol('style','pushbutton','String','remove',                  ...
                                                  'Parent',panel_png,               ...
                                                  'Units','normalized',             ...
                                                  'Position',[0.65 0.15 0.15 0.35],    ...
                                                  'Callback',{@btn_removeCallback,h}, ...
                                                  'Tag','btnremove');
    
    checkbox_view =  uicontrol('style','checkbox','String',{'View'},                      ...
                                                  'Parent',panel_png,                   ...
                                                  'Units','normalized',                 ...
                                                  'Position',[0.825 0.2 0.2 0.5],       ...    
                                                  'Callback',{@check_viewCallback,h},   ...
                                                  'Tag','checkboxview');

%% Panel Title: Dimension
panel_dimension = uipanel(panel_control,'Title','Dimension','Units','normalized','Position',[0.65 0.00 0.35 1.0],'Tag','Dimension');

    text_xlim = uicontrol('style','text','Parent',panel_dimension, ...
                                           'String','xlim(m)',     ...
                                           'Units','normalized',  ...
                                           'Position',[0.05 0.5 0.15 0.3]);
    edit_xlim = uicontrol('style','edit','Parent',panel_dimension, ...
                                           'String','50',          ...
                                           'Units','normalized',  ...
                                           'Position',[0.25 0.5 0.1 0.3], ...
                                           'Tag','xlim');
    
    text_ylim = uicontrol('style','text','Parent',panel_dimension, ...
                                           'String','ylim(m)',     ...
                                           'Units','normalized',  ...
                                           'Position',[0.05 0.05 0.15 0.3]);
    edit_ylim = uicontrol('style','edit','Parent',panel_dimension, ...
                                           'String','50',          ...
                                           'Units','normalized',  ...
                                           'Position',[0.25 0.1 0.1 0.3], ...
                                           'Tag','ylim');
    
   btn_fix = uicontrol('style','pushbutton','Parent',panel_dimension, ...
                                           'String','fix',          ...
                                           'Units','normalized',  ...
                                           'Position',[0.375 0.3 0.1 0.3], ...
                                           'Callback',{@btn_fix_planimetry,h}, ...
                                           'Tag','btnfix');
                                       
                                       
                                       
    text_xlim_scale = uicontrol('style','text','Parent',panel_dimension, ...
                                           'String','xlim(scale)',     ...
                                           'Units','normalized',  ...
                                           'Position',[0.55 0.5 0.2 0.3]);
    edit_xlim_scale = uicontrol('style','edit','Parent',panel_dimension, ...
                                           'String','1',          ...
                                           'Units','normalized',  ...
                                           'Position',[0.75 0.5 0.1 0.3], ...
                                           'Tag','xlimscale');
    
    text_ylim_scale = uicontrol('style','text','Parent',panel_dimension, ...
                                           'String','ylim(scale)',     ...
                                           'Units','normalized',  ...
                                           'Position',[0.55 0.05 0.2 0.3]);
    edit_ylim_scale = uicontrol('style','edit','Parent',panel_dimension, ...
                                           'String','1',          ...
                                           'Units','normalized',  ...
                                           'Position',[0.75 0.1 0.1 0.3], ...
                                           'Tag','ylimscale');                                       
                                       
    btn_scale = uicontrol('style','pushbutton','Parent',panel_dimension, ...
                                           'String','Scale',          ...
                                           'Units','normalized',  ...
                                           'Position',[0.875 0.3 0.1 0.3], ...
                                           'Callback',{@btn_scale_planimetry,h}, ...
                                           'Tag','btnscale');                                  
%% Panel Title: Other Controls
%%panel_others     = uipanel(panel_control,'Title','Other Options' ,'Position',[0.9 0.05 0.1 0.9],'Tag','Other Options');
   




end
