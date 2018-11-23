function CT04_panel_info_objects(h,panel_info)
%CT02_PANEL_INFO_OBJECTS Summary of this function goes here
%   Detailed explanation goes here

    xedit = 0.4; h_edit = 0.25;wd_edit = 0.55; 
    xtext = 0.05; h_text = 0.25;
    
                               
                                       
    %% �Generate?
    text_generate = uicontrol('style','text','Parent',panel_info,            ...
                                           'String','Generate:',         ...
                                           'Units','normalized',             ...
                                           'Position',[xtext-0.05 0.55 0.4 h_text]);
                                       
                                       
    edit_generate = uicontrol('style','text','Parent',panel_info,      ...
                                           'String',' ',                     ...
                                           'Units','normalized',             ...
                                           'Position',[xedit 0.55 wd_edit h_edit],  ...
                                           'Tag','Generate:',            ...
                                           'Enable','on');
                                       
    %% Label 
    text_label = uicontrol('style','text','Parent',panel_info,             ...
                                           'String','Label:',                ...
                                           'Units','normalized',             ...
                                            'Position',[xtext 0.15 0.4 h_text]);
                                        
    edit_label = uicontrol('style','edit','Parent',panel_info,                        ...
                                           'String',' ',                                ...
                                           'Units','normalized',                        ...
                                           'Position',[xedit 0.15 wd_edit h_edit],             ...
                                           'Callback',{@edit_label_estimator_Callback,h},   ...
                                           'Tag','Label:');                                        

end
