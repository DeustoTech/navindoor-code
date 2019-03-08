classdef graphs_objects_level
    %GRAPHS_OBJECTS_LEVEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nodes
        walls
        beacons
        doors
        stairs
        elevators
    end
    
    methods
        function delete(obj)
           delete(obj.nodes)
           delete(obj.walls)
           delete(obj.beacons)
           delete(obj.doors)
           delete(obj.stairs)
           delete(obj.elevators)
        end
    end
end

