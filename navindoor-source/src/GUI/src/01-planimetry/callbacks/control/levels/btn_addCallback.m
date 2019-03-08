function btn_addCallback(object,event,h)
%BTN_ADDCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    listbox_buildings = findobj_figure(h.iur_figure,'Planimetry','Buildings','listbox');
    index_buildings = listbox_buildings.Value;
    
    
    h.planimetry_layer(index_buildings).level_layer(end+1) = level_layer;
    
    if length(h.planimetry_layer(index_buildings).level_layer) > 1
    	h.planimetry_layer(index_buildings).level_layer(end).height = h.planimetry_layer(index_buildings).level_layer(end-1).height + 5;
    else
        h.planimetry_layer(index_buildings).level_layer(end).height = 0;
    end
        update_planimetry_layer(h)
    
    
end

