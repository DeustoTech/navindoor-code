classdef OsmBuilding < OsmWay
    %OSMBUILDING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function obj = OsmBuilding(id,nodes)
           obj@OsmWay(id,nodes);
        end
    end
end

