classdef level_layer < handle
    %LEVEL_LAYER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nodes        = zeros(0,0,'node')
        walls        = zeros(0,0,'wall')
        doors        = zeros(0,0,'door')
        elevators    = zeros(0,0,'elevator')     
        stairs       = zeros(0,0,'stairs')
        beacons      = zeros(0,0,'beacon')
        height               = 0
     
        picture_level = graphs_picture_level.empty 
        layer_graphs = graphs_objects_level
    end
    
end

