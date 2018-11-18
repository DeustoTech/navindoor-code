classdef building 
    properties
        levels      level       =  zeros(0,0,'level')        % list of objects levels 
        connections connection   =  zeros(0,0,'connection')   % list of objects type connections that represents connections of stairs or elevators 
    end

    methods
        function plot(obj,ax,varargin)
            for ilevel = obj.levels
               line3(ilevel,ax,varargin{:}) 
            end            
        end
    end
end

