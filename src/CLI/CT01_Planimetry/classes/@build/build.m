classdef build 
    % set of levels 
    
    properties
        levels  = zeros(1,1,'level')        % list of levels 
        len = 1                             % length of levels 
        connections = []                    % list of objects type 'wall' that represents stairs or elevators 
 
        height_levels = []                  % list of the height of every level 
    end
    
    methods
        function obj = build(levels,connections)
           % This condition is neccesary to define the null element 
           
           if nargin > 0
                obj.levels = levels;
                obj.len = length(levels);

                for index=1:obj.len
                    if obj.levels(index).n ~= index - 1
                        obj.levels(index).n = index - 1; 
                    end
                end
                obj.connections = connections; 
            else
                obj.levels = level;
            end
        end
        
        function obj=set.height_levels(obj,value)
            index = 0;
            for hights = value
               index = index + 1; 
               obj.levels(index).high = hights;
            end
            obj.height_levels = value;
        end
        

    end
end

