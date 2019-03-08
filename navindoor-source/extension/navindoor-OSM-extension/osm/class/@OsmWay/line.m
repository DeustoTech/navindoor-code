function h = line(ways,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here
    h = gobjects(length(ways),1);
    index = 0;
    for iway = ways
        index = index +1;
       h(index) = line(iway.OsmNodes,varargin{:}) ;
    end
end

