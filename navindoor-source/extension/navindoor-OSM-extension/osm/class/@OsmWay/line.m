function line(ways,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here
    for iway = ways
       line(iway.OsmNodes,varargin{:}) 
    end
end

