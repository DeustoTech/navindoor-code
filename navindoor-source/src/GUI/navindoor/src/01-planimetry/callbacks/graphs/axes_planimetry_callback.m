function axes_planimetry_callback(object,event,h)
%AXES_PLANIMETRY_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
control_panel  = findobj(h.iur_figure,'Title','Levels');
list_box   = findobj(control_panel,'Style','listbox');


index_level = list_box.Value;

option = h.javacomponets.planimetry_layer.btngrp_option.getSelection.getActionCommand();
option = [option.toCharArray]';
mode   = h.javacomponets.planimetry_layer.btngrp_mode.getSelection.getActionCommand();
mode = [mode.toCharArray]';

C = object.CurrentPoint;
height = h.planimetry_layer(index_level).height;
cnode = node([C(1,1),C(1,2) height]);

vb = h.planimetry_layer(index_level);
precision = (0.05 *  sqrt( (object.XLim(2)-object.XLim(1))^2 + (object.YLim(2)-object.YLim(1))^2 ));

switch mode
    case 'nodes'
        mode_nodes(vb,cnode,option,precision)
    case 'walls'
        mode_walls(vb,cnode,option,precision,index_level)
    case 'doors'
        mode_doors(vb,cnode,option,precision,index_level)
    case 'elevators'
        mode_elevators(vb,cnode,option,precision,index_level)
    case 'stairs'
        mode_stairs(vb,cnode,option,precision,index_level)
    case 'connections'
        vb = h.planimetry_layer(1);
        mode_connections(vb,cnode,option,precision,index_level)
    case 'beacons'
        mode_beacons(vb,cnode,option,precision,index_level)

end

update_planimetry_layer(h,'auto_zoom',false,'replot',true);

end

