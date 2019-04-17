function open_building_Callback(object,event,h)
%OPEN_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
    [namemat,path] = uigetfile('*.mat','Select the MATLAB code file');
    
    if namemat ~= 0
        file = strcat(path,namemat);
        building = [];
        load(file, 'building')
        len=length(building.levels);
        h.planimetry_layer = planimetry_layer
        
        index_building = h.DirectAccess.Planimetry.listbox_building.Value;
        h.planimetry_layer.building_layers(index_building) = building_layer;
        
        for index = 1:len
            h.planimetry_layer.building_layers(index_building).level_layer(index) = level_layer;
            ilevel_layer = h.planimetry_layer.building_layers(index_building).level_layer(index);
            
            ilevel_layer.height = building.levels(index).height;
            
            ilevel_layer.walls = building.levels(index).walls;
            ilevel_layer.nodes = building.levels(index).nodes;
            ilevel_layer.doors = building.levels(index).doors;
            ilevel_layer.beacons = building.levels(index).beacons; 
            ilevel_layer.stairs = building.levels(index).stairs; 
            ilevel_layer.elevators = building.levels(index).elevators; 
            
        end
                
        update_planimetry_layer(h,'auto_zoom',true)

    end
    
end

