classdef point
    %POINT three-dimensional points in spaces 
    
    properties
        x           % x-coordinate of point
        y           % y-coordinate of point
        z           % z-coordinate of point
    end
    
    properties (Hidden)
        r
    end
    methods
        function obj = point(r)
            %POINT Construct an instance of this class
            %   Detailed explanation goes here
            if nargin == 0
                return
            end
            %%
            obj.r = r;
        end
        function obj = set.r(obj,r)
            obj.x = r(1);
            obj.y = r(2);
            obj.z = r(3);   
            obj.r = r;   
        end

    end
    
    methods (Static)
      function z = zeros(varargin)
         if (nargin == 0)
         % For zeros('point')
            z = point;
         elseif any([varargin{:}] <= 0)
         % For zeros with any dimension <= 0   
            z = point.empty(varargin{:});
         else
         % For zeros(m,n,...,'Color')
         % Use property default values
            z = repmat(point,varargin{:});
         end
      end
    end
end

