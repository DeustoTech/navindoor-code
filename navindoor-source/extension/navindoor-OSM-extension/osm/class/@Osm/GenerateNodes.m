function GenerateNodes(obj)
%GENERATENODES Summary of this function goes here
%   Detailed explanation goes here

    nodes = OsmNode.empty;
    index = 0;
    for inode = obj.xml.node
       index = index + 1;
       id  = inode{:}.Attributes.id;
       lat = str2num(inode{:}.Attributes.lat);
       lon = str2num(inode{:}.Attributes.lon);
       nodes(index) = OsmNode(id,lat,lon);
    end
    obj.OsmNodes = nodes;
end

