function CT03_panel_supertrajs(h,panel_graphs)
%CT02_PANEL_SUPERTRAJS Summary of this function goes here
%   Detailed explanation goes here
    

    listbox_supertraj  = uicontrol('style','listbox',    'Parent',panel_graphs,        ...
                                                         'FontName','Comic Sans MS',    ...
                                                         'FontSize',12,                 ...
                                                         'String','' ,                 ...
                                                         'Units','normalized',         ... 
                                                         'Position',[0.1 0.1 0.8 0.8], ...
                                                         'Tag','listbox',              ...
                                                         'Callback',{@listboxSupertrajSignalsCallback,h});

end

