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
            obj.SWnode = OsmNode('LimitSW',LonMin,LatMin);
            obj.SEnode = OsmNode('LimitSE',LonMax,LatMin);
            obj.NWnode = OsmNode('LimitNW',LonMin,LatMax);
            obj.NEnode = OsmNode('LimitNE',LonMax,LatMax);
        end
    end
end

