classdef OsmWay < handle
    %OSMWAY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id          char        = char.empty
        OsmNodes    OsmNode     = OsmNode.empty
    end
    
    methods
        function obj = OsmWay(id,OsmNodes)

            if nargin == 0
               return 
            end
            %
            obj.OsmNodes = OsmNodes;
            obj.id = id;
        end
        
    end
end

