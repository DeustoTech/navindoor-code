classdef iur_handles < handle
    %IUR_HANDLES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        iur_figure
        zoom_iurfigure
        pan_iurfigure
        
        javacomponets
        %
        planimetry_layer
        trajectory_layer
        signal_layer
        processing_layer
        % 
        graphs_trajectory_layer

        %
        
        openning_box
        AvailableTraj
        path
        navindoor_path
        DirectAccess
        
        png_edit
        
    end
    
    methods
        function obj = iur_handles
        obj.graphs_trajectory_layer.trajectory = [];
        obj.graphs_trajectory_layer.planimetry = [];
        end
    end
end

