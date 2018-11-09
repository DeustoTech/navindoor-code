classdef planimetry_layer < handle
    %PLANIMETRY_LAYER Summary of this class goes here
    %   Detailed explanation goes here
   
    properties
        %% Bar tools 
        nodes 
        walls        
        doors
        elevators        
        stairs
        connections = zeros(0,0,'connection')
        beacons
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
    end
    

end

