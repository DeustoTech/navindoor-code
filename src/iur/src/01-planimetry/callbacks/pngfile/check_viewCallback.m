function check_viewCallback(object,event,h)
%CHECK_VIEWCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    % refrescamos la figure
    tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
    control_panel  = findobj(h.iur_figure,'Title','Levels');
    list_box   = findobj(control_panel,'Style','listbox');

    index_level = list_box.Value;
    
    h.planimetry_layer(index_level).showfigure = boolean(object.Value);
    
    update_planimetry_layer(h)
    
end

