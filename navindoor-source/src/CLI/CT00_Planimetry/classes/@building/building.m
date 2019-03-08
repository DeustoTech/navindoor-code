classdef building < handle
    properties
        levels      level        =  level.empty        % list of objects levels 
        connections connection   =  connection.empty   % list of objects type connections that represents connections of stairs or elevators 
        border      images.roi.Polygon         =  images.roi.Polygon.empty
    end

    methods
        function plot(border,obj,ax,varargin)
            if ~exist('ax','var')
                f = figure;
                ax = axes('Parent',f);
            end
            for ilevel = obj.levels
               line3(ilevel,ax,varargin{:}) 
            end       
            
            view(25,25)
        end
    end
end

