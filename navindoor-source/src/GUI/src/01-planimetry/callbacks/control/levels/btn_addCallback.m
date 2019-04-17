function btn_addCallback(object,event,h)
%BTN_ADDCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    listbox_buildings = findobj_figure(h.iur_figure,'Planimetry','Buildings','listbox');
    index_buildings = listbox_buildings.Value;
    
    
    h.planimetry_layer.building_layers(index_buildings).level_layer(end+1) = level_layer;
    
    if length(h.planimetry_layer.building_layers(index_buildings).level_layer) > 1
    	h.planimetry_layer.building_layers(index_buildings).level_layer(end).height = h.planimetry_layer.building_layers(index_buildings).level_layer(end-1).height + 5;
    else
        h.planimetry_layer.building_layers(index_buildings).level_layer(end).height = 0;
    end
    update_planimetry_layer(h)
    
    height          = h.planimetry_layer.building_layers(index_buildings).level_layer(end).height;
    border_position = h.planimetry_layer.building_layers(index_buildings).border.position;
    number_nodes    = length(border_position(:,1));
    %
    nodes = arrayfun(@(index)node([border_position(index,:) height]),1:number_nodes);
    
    index_nodes = [mod(0:(number_nodes-1),number_nodes)+1;mod(1:number_nodes,number_nodes)+1];
    walls =  arrayfun(@(index)wall([nodes(index_nodes(1,index)),nodes(index_nodes(2,index))]),1:number_nodes);
    
    h.planimetry_layer.building_layers(index_buildings).level_layer(end).walls = walls;
    
    h.planimetry_layer.building_layers(index_buildings).level_layer(end).nodes = nodes;

end

