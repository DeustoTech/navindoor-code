classdef planimetry_layer < handle
    %PLANIMETRY_LAYER Summary of this class goes here
    %   Detailed explanation goes here
   
    properties
        %% Bar tools 
        nodes        = zeros(0,0,'node')
        walls        = zeros(0,0,'wall')
        doors        = zeros(0,0,'door')
        elevators    = zeros(0,0,'elevator')     
        stairs       = zeros(0,0,'stairs')
        connections  = zeros(0,0,'connection')
        beacons      = zeros(0,0,'beacon')
        %%%
        building = building
        %%
        % png file properties
        pngfile             = ' '
        image_map           = []
        XLim_image          = []
        YLim_image          = []
        showfigure          = false

        % dimension of level
        XLim                = [0 50]
        YLim                = [0 50]
        % hight 
        height               = 0
        layer_graphs
    end
    
    methods
        function obj = planimetry_layer
            obj.layer_graphs.nodes = [];
            obj.layer_graphs.walls = [];
            obj.layer_graphs.beacons = [];
            obj.layer_graphs.doors = [];
            obj.layer_graphs.stairs = [];
            obj.layer_graphs.elevators = [];

        end
    end
end

