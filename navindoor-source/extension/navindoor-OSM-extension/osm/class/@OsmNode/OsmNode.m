classdef OsmNode < handle
    %OSMNODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id
        lat 
        lon 
        x           % este - oeste
        y           % norte - sur
        zone
    end
    
    methods
        function obj = OsmNode(id,lon,lat)
            %OSMNODE 
            obj.id = id;
            obj.lat = lat;
            obj.lon = lon;
            %%
            [obj.x ,obj.y ,obj.zone] = ell2utm((pi/180)*lat,(pi/180)*lon);
        end
        
    end
end

