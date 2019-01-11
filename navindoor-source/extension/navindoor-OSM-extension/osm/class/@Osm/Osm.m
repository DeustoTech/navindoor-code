classdef Osm < handle
    %OSM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        xml
        OsmNodes
        OsmWays
        OsmBuilding
        limits
    end
    
    methods
        function obj = Osm(xml_path)
            %OSM Construct an instance of this class
            %   Detailed explanation goes here
            xml = xml2struct(xml_path);
            obj.xml = xml.osm;
            
            GenerateNodes(obj)
            GenerateWays(obj)
            %% Save Limits
            MinLat = str2num(obj.xml.bounds.Attributes.minlat);
            MaxLat = str2num(obj.xml.bounds.Attributes.maxlat);
            
            MinLon = str2num(obj.xml.bounds.Attributes.minlon);
            MaxLon = str2num(obj.xml.bounds.Attributes.maxlon);
            
            obj.limits = OsmLimits(MinLat,MaxLat,MinLon,MaxLon);
            
            
            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

