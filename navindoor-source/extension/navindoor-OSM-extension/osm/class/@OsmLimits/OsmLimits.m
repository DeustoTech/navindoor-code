classdef OsmLimits < handle
    %LIMITS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        LatMax
        LatMin
        LonMax
        LonMin
    end
 
    properties (Hidden)
        SWnode  OsmNode = OsmNode.empty
        SEnode  OsmNode = OsmNode.empty
        NWnode  OsmNode = OsmNode.empty
        NEnode  OsmNode = OsmNode.empty
    end
    
    methods

        function obj = OsmLimits(LatMin,LatMax,LonMin,LonMax)
            %%
            obj.LatMax = LatMax;
            obj.LatMin = LatMin;
            obj.LonMax = LonMax;
            obj.LonMin = LonMin;

            %%
            obj.SWnode = OsmNode('LimitSW',LatMin,LonMin);
            obj.SEnode = OsmNode('LimitSE',LatMin,LonMax);
            obj.NWnode = OsmNode('LimitNW',LatMax,LonMin);
            obj.NEnode = OsmNode('LimitNE',LatMax,LonMax);

        end
        
        function [x,y] = xylimits(obj)
            x = [obj.SWnode.x  obj.SEnode.x];
            y = [obj.SEnode.y  obj.NEnode.y];
            
        end
    end
end

