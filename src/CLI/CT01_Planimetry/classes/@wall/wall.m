 classdef wall
    
    properties 
        nodes = [node([0 0]) node([1 1])];
        level = 0;
        mt_nodes = []
        long = 0
        width = 1
        doors = zeros(0,0,'door')
        m = 0
        n = 0
        intervals = []
    end

    methods
        %% Constructor & Settings
        function obj = wall(nodes)
            if nargin > 0 
                [~ , indexs] = sort([nodes(1).r(1) nodes(2).r(1)]);
                obj.nodes = nodes(indexs);
                obj.intervals.xmin = nodes(indexs(1)).r(1);
                obj.intervals.xmax = nodes(indexs(2)).r(1);

                [~ , indexs] = sort([nodes(1).r(2) nodes(2).r(2)]);
                obj.intervals.ymin = nodes(indexs(1)).r(2);
                obj.intervals.ymax = nodes(indexs(2)).r(2);

            end

            % validations
            %
            % matrix 2x2 of nodes
            if length(obj.nodes) > 2
                error('the wall must have only 2 nodes' )
            end
            % the nodes must be uniques
            obj.mt_nodes = vec2mat([obj.nodes(1).r obj.nodes(2).r],2);
            if length(unique(obj.mt_nodes,'rows')) ~= length(obj.mt_nodes)
                error('Some nodes are the same');
            end
            obj.long = distn(obj.nodes(1),obj.nodes(2));
            r1 = obj.nodes(1);
            r2 = obj.nodes(2);         

            if (r2.r(1)-r1.r(1)) ~= 0
                obj.m = (r2.r(2)-r1.r(2))/(r2.r(1)-r1.r(1));
                obj.n = r1.r(2) - obj.m*r1.r(1);
            else
                obj.m = Inf;
                obj.n = r2.r(1);
            end
            
             
        end
        function obj = set.nodes(obj,value) 
            % validations ...
            if isa(value,'node')
                obj.nodes = value;
            else
                error('first argummet must be type node');
            end
        end        
        function obj = set.width(obj,value) 
                obj.width = value;
        end
        %% Methods '='
        function result = eq(wall1,wall2)    
         %%
            if ( wall1.nodes(1) == wall2.nodes(1)  ||   wall1.nodes(1) == wall2.nodes(2)   ) && ...
               ( wall1.nodes(2) == wall2.nodes(1)  ||   wall1.nodes(2) == wall2.nodes(2)   )
                result = true;
            else
                result = false;
            end    
        end
        
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
