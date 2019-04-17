function GenerateMap(iplanimetry_layer)

    iplanimetry_layer.map = map;
    
    ibuilding = building.empty;
    for index_building = 1:length(iplanimetry_layer.building_layers)
        ibuilding(index_building) = building;
        for index_level = 1:length(iplanimetry_layer.building_layers(index_building).level_layer)
            ibuilding(index_building).levels(index_level)  = level;
            ibuilding(index_building).levels(index_level).height       = iplanimetry_layer.building_layers(index_building).level_layer(index_level).height;
            ibuilding(index_building).levels(index_level).nodes        = iplanimetry_layer.building_layers(index_building).level_layer(index_level).nodes;
            ibuilding(index_building).levels(index_level).walls        = iplanimetry_layer.building_layers(index_building).level_layer(index_level).walls;
            ibuilding(index_building).levels(index_level).doors        = iplanimetry_layer.building_layers(index_building).level_layer(index_level).doors; 
            ibuilding(index_building).levels(index_level).elevators    = iplanimetry_layer.building_layers(index_building).level_layer(index_level).elevators; 
            ibuilding(index_building).levels(index_level).stairs       = iplanimetry_layer.building_layers(index_building).level_layer(index_level).stairs;
            ibuilding(index_building).levels(index_level).beacons       = iplanimetry_layer.building_layers(index_building).level_layer(index_level).beacons;
        end
        ibuilding(index_building).border                           = iplanimetry_layer.building_layers(index_building).border;

        %% 
    end
    iplanimetry_layer.map.buildings = ibuilding;
end

