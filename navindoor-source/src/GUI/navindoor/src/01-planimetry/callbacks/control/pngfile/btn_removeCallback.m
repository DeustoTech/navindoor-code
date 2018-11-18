function btn_removeCallback(object,event,h)
%BTN_LOADCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    % selection of level 
    tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
    control_panel  = findobj(h.iur_figure,'Title','Levels');
    list_box   = findobj(control_panel,'Style','listbox');

    index_level = list_box.Value;
    vb  = h.planimetry_layer(index_level);
    
    
    vb.image_map = [];
     % activamos el chexbox para que se pueda ver 
     % la imagen cargada
     vb.showfigure = 0;

    % refrescamos la figure
    update_planimetry_layer(h)
    
    
end

