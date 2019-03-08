classdef iur_handles < handle
    %IUR_HANDLES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mapfile
        osm
        graph_layout_osm_ways
        graph_layout_osm_buildings
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
        path
        DirectAccess
        png_edit = false;
    end
    
    methods

    end
end

