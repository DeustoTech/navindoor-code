function CT02_panel_navigation(h,panel)
%CT02_PANEL_NAVEGATION 
    %%
    panel_inout         = uipanel(panel,'Title','In/Out','Position',[0.00    0.00    0.33   1.00],'Tag','In/Out');
    
    uicontrol('style'       ,     'listbox',                          ...
              'Parent'      ,     panel_inout,                        ...
              'String'      ,     {'--In--','-Out-'},                 ...
              'Units'       ,     'normalized',                       ... 
              'Position'    ,     [0.1 0.1 0.7 0.8],                  ...
              'Callback'    ,     {@ListBox_Navigation_InOut,h},    ...
              'Tag'         ,     'listbox');
  %%
    panel_buildings    = uipanel(panel,'Title','Buildings'   ,'Position',[0.33    0.00    0.33   1.00],'Tag','Buildings');

    uicontrol('style'       ,   'listbox',                                     ...
              'Parent'      ,   panel_buildings,                               ...
              'String'      ,   {},                                           ...
              'Units'       ,   'normalized',                                  ... 
              'Position'    ,   [0.1 0.1 0.7 0.8],                             ...
              'Callback'    ,   {@ListBox_Navigation_Buildings,h},             ...
              'Tag'         ,   'listbox');
  %% 
    panel_levels        = uipanel(panel,'Title','Levels'   ,'Position',[0.66    0.00    0.33   1.00],'Tag','Levels');

    uicontrol('style'       ,     'listbox',                          ...
              'Parent'      ,     panel_levels,                       ...
              'String'      ,     {},                                ...
              'Units'       ,     'normalized',                       ... 
              'Position'    ,     [0.1 0.1 0.7 0.8],                  ...
              'Callback'    ,     {@ListBox_Navigation_Levels,h},     ...
              'Tag'         ,     'listbox');


  %%

end

