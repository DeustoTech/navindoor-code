 classdef wall < handle
    % WALL is the object that represent a wall, this contain two nodes.
    % *** Example
    %
        properties 
            nodes   (1,2) node   {mustBeDiff}         = [node([0 0 0]) node([1 1 1])];      % List of nodes 
            width   (1,1) double {mustBePositive}     = 1                               % width of wall
            doors         door                        = zeros(0,0,'door')               % List of doors that the wall contain
            level   (1,1) double                      = 0
        end

        properties (Hidden)
            m       (1,1) double                    
            n       (1,1) double
            select  (1,1) logical                     = false
            intervals
        end
        
        methods
            %% Constructor & Settings
            function obj = wall(nodes,varargin)
                if nargin == 0 
                   return; 
                end
                obj.nodes = nodes;
                
                nodes(1).walls = [nodes(1).walls obj];
                nodes(2).walls = [nodes(2).walls obj];
                
                %% In 2D, wall can be defined by y = m*x + n
                r1 = obj.nodes(1);
                r2 = obj.nodes(2);         

                if (r2.r(1)-r1.r(1)) ~= 0
                    obj.m = (r2.r(2)-r1.r(2))/(r2.r(1)-r1.r(1));
                    obj.n = r1.r(2) - obj.m*r1.r(1);
                else
                    obj.m = Inf;
                    obj.n = r2.r(1);
                end
            
                obj.intervals.xmin = min([obj.nodes(1).r(1) obj.nodes(2).r(1)]);
                obj.intervals.xmax = max([obj.nodes(1).r(1) obj.nodes(2).r(1)]);
                
                obj.intervals.ymin = min([obj.nodes(1).r(2) obj.nodes(2).r(2)]);
                obj.intervals.ymax = max([obj.nodes(1).r(2) obj.nodes(2).r(2)]);              
            end
            
            function set.doors(obj,doors)
                obj.doors = doors;
            end
            %%
            function result = eq(wall1,wall2)    

                if ( wall1.nodes(1) == wall2.nodes(1)  ||   wall1.nodes(1) == wall2.nodes(2)   ) && ...
                   ( wall1.nodes(2) == wall2.nodes(1)  ||   wall1.nodes(2) == wall2.nodes(2)   )
                    result = true;
                else
                    result = false;
                end    
            end
            %%
            function result = times(obj1,obj2)

                if isa(obj1,'double')
                    number = obj1;
                    obj = obj2;
                elseif isa(obj2,'double')
                    number = obj2;
                    obj = obj1;
                else 
                    error('Must be node*numeric')
                end

                result = arrayfun(@(x) tmwall(x,number),obj);
                function new_wall =tmwall(old_wall,number)
                    new_wall = wall(number.*[old_wall.nodes]);
                    new_wall.doors = 2.*old_wall.doors; 
                    new_wall.width = old_wall.width;
                end
            end
    
             
    end 
    
    
       methods (Static)
          function z = zeros(varargin)
             if (nargin == 0)
             % For zeros('Color')
                z = wall;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = wall.empty(varargin{:});
             else
             % For zeros(m,n,...,'Color')
             % Use property default values
                z = repmat(wall,varargin{:});
             end
          end
       end
    
end
