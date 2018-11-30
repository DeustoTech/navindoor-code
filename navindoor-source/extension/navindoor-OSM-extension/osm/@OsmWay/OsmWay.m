classdef OsmWay < handle
    %OSMWAY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id
        OsmNodes
    end
    
    methods
        function obj = OsmWay(id,OsmNodes)
            %OSMWAY Construct an instance of this class
            %   Detailed explanation goes here
            obj.OsmNodes = OsmNodes;
            obj.id = id;
        end
        
    end
end

