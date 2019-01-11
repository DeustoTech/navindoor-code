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
        openning_box
        st
        click = false
        AvailableTraj
    end
    
    methods

    end
end

