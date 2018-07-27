classdef network < handle
    %TREE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        vertexs  
        branchs
        len
        maxstep = 5;
    end
    
    methods
        %% Constructor
        function obj = network(maxstep)
            %% TREE Construct an instance of this class
            %   Detailed explanation goes here
            if nargin > 0
                obj.maxstep = maxstep;
            end
            obj.len = 0;
        end          

    end
end

