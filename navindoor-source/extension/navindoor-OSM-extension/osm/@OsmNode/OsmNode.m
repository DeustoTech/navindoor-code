classdef OsmNode < handle
    %OSMNODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id
        lat 
        lon 
        x
        y
        zone
    end
    
    methods
        function obj = OsmNode(id,lon,lat)
            %OSMNODE Construct an instance of this class
            %   Detailed explanation goes here
            obj.id = id;
            obj.lat = lat;
            obj.lon = lon;

        end
        
    end
end

