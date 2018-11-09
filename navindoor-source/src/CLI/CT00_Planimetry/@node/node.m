 classdef node < handle

    properties 
        r       (1,3) double          = [0 0 0]  % r is a matrix 1x3 that cotains the x ans y coordinates of node.  
    end
    
    properties (Hidden)
        select  (1,1) logical         = false
        walls 
    end
    
    methods
        %% Constructor & Settings
        function obj = node(r)
            if nargin == 0
                return
            end
            obj.r = r;
        end        

        %% Arithmetic methods:  = - + *
        function result = eq(lobj2,lobj1)        
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
  %% Zeros constructor 

    methods (Static)
          function z = zeros(varargin)
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
