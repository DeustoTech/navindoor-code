function GenerateWays(obj)
%GENERATEWAYS Summary of this function goes here
%   Detailed explanation goes here

ways = OsmWay.empty;
idx_wy = 0;
for iway = obj.xml.osm.way 
    nodes = OsmNode.empty;
    idx_nd = 0;
    for nd = iway{:}.nd
       id = nd{:}.Attributes.ref;
       idx_nd = idx_nd + 1;
       nodes(idx_nd) = FindByID(obj.OsmNodes,id);
    end
    
    id = iway{:}.Attributes.id;
    idx_wy = idx_wy + 1;
    ways(idx_wy) = OsmWay(id,nodes);
end

obj.OsmWays = ways;
