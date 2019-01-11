classdef building < handle
    properties
        levels      level        =  level.empty        % list of objects levels 
        connections connection   =  connection.empty   % list of objects type connections that represents connections of stairs or elevators 
        border      node         =  node.empty
    end

    methods
        function plot(obj,ax,varargin)
            for ilevel = obj.levels
               line3(ilevel,ax,varargin{:}) 
            end            
        end
    end
end
