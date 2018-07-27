function open_Callback(object,event,h)
%OPEN_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
    [namemat,path] = uigetfile('*.mat','Select the MATLAB code file');
    
    if namemat ~= 0
        file = strcat(path,namemat);
        building = [];
        load(file, 'building')
        len=length(building.levels);
        h.planimetry_layer = planimetry_layer;
        for index = 1:len
            h.planimetry_layer(index).hieght = building.levels(index).high;

            
            h.planimetry_layer(index).walls = building.levels(index).walls;
            h.planimetry_layer(index).nodes = building.levels(index).nodes;
            h.planimetry_layer(index).doors = building.levels(index).doors;
            h.planimetry_layer(index).beacons = building.levels(index).beacons; 
            h.planimetry_layer(index).stairs = building.levels(index).stairs; 

            h.planimetry_layer(index).select_nodes = [];h.planimetry_layer(index).select_walls=[];
            h.planimetry_layer(index).select_doors = [];h.planimetry_layer(index).select_beacons=[];
            h.planimetry_layer(index).XLim = [ 0 building.levels(index).dimensions(1)];
            h.planimetry_layer(index).YLim = [ 0 building.levels(index).dimensions(2)];
            
            
        end
        h.planimetry_layer(1).connections = building.connections;
        h.planimetry_layer(1).elevators = [building.levels.elevators];
        h.planimetry_layer(1).stairs = [building.levels.stairs];

        
        h.planimetry_layer(1).build = building;
                
        update_planimetry_layer(h)

    end
    
end

