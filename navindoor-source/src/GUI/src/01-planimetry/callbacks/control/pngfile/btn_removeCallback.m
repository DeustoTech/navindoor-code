function btn_removeCallback(object,event,h)
%BTN_LOADCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    % selection of level 
    index_levels    = GetIndexLevel(h);
    index_buildings = GetIndexBuilding(h);
    
    
    vb  = h.planimetry_layer.building_layers(index_buildings).level_layer(index_levels);
    
    if ~isempty(vb.picture_level)
    delete(vb.picture_level.picture.Image)
    vb.picture_level = graphs_picture_level.empty;

    % refrescamos la figure
    update_planimetry_layer(h)
    end
   
    PNGbtnstate(h,'empty')
end

