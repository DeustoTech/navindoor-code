 classdef node
 %% node is the most basic element of the structure level. 
    properties 
        r      = [0 0] % r is a matrix 1x2 that cotains the x ans y coordinates of node 
        level  =  0    % nlevel is an integer that indicates to which level this node belongs
        height = 0
    end
    
    methods
        %% Constructor & Settings
        function obj = node(r,level)
            switch nargin 
                case 1 
                    obj.r = r;
                case 2 
                    obj.r = r;
                    obj.level = level;
            end
        end        
        function obj = set.r(obj,value) 
            if ~isnumeric(value) 
                error('first arrgument must be numeric');
            end
            if length(value) ~= 2  
                if ~isempty(value)
                error('first arrgument must be matrix 1x2');
                end
            end
            obj.r = value;
        end
        function obj = set.level(obj,value) 
            % validations ...
            if isnumeric(value) 
                obj.level = value;
            else
                error('second arrgument must be integer');
            end
        end
        %% Arithmetic methods:  = - + *
        function result = eq(lobj2,lobj1)
        %% equal 
        
            result = zeros(length(lobj1),length(lobj2),'logical');
            
            for ix=1:length(lobj1)
               for iy=1:length(lobj2)
                   result(ix,iy) = eq1(lobj1(ix),lobj2(iy));
               end
            end
        
        
            function r=eq1(obj1,obj2)
                if  obj1.r(1) == obj2.r(1) &&  obj1.r(2) == obj2.r(2)
                    r = true;
                else
                    r = false;
                end
            end
        end
        function result = minus(obj1,obj2)
            fun=str2func(class(obj1));
            result = fun(obj1.r-obj2.r);
        end
        function result = plus(obj1,obj2)
            fun=str2func(class(obj1));
            result = fun(obj1.r+obj2.r);
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
            fun=str2func(class(obj));
            result = arrayfun(@(x)fun(x.r*number),obj);
            %result = fun(obj.r*number);
        end
    end  
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = node;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = node.empty(varargin{:});
             else
             % Use property default values
                z = repmat(node,varargin{:});
             end
          end
       end

end
