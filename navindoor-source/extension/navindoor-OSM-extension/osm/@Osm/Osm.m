classdef Osm < handle
    %OSM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        xml
        OsmNodes
        OsmWays
    end
    
    methods
        function obj = Osm(xml_path)
            %OSM Construct an instance of this class
            %   Detailed explanation goes here
            obj.xml = xml2struct(xml_path);
            GenerateNodes(obj)
            GenerateWays(obj)
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

