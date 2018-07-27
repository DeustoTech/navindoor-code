classdef planimetry_layer < handle
    %PLANIMETRY_LAYER Summary of this class goes here
    %   Detailed explanation goes here
   
    properties
        %% Bar tools 
        nodes 
        select_nodes 
        
        walls
        select_walls
        
        doors
        select_doors
        
        elevators
        select_elevators 
        
        stairs
        select_stairs
        
        connections 
        select_connections
        
        beacons
        select_beacons 
        %%%
        build = build
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
        hieght               = 0
    end
    
    methods
        function unselect(obj)
            obj.nodes       = [obj.nodes        obj.select_nodes];
            obj.walls       = [obj.walls        obj.select_walls];
            obj.doors       = [obj.doors        obj.select_doors];
            obj.elevators   = [obj.elevators    obj.select_elevators];
            obj.stairs      = [obj.stairs       obj.select_stairs];
            obj.connections = [obj.connections  obj.select_connections];
            obj.beacons     = [obj.beacons      obj.select_beacons];
            
            obj.select_nodes       = [];
            obj.select_walls       = [];
            obj.select_doors       = [];
            obj.select_elevators   = [];
            obj.select_stairs      = [];
            obj.select_connections = [];
            obj.select_beacons     = [];
            
        end
        
    end
end

