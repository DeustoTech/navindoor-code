classdef point < matlab.mixin.Copyable
    %POINT three-dimensional points in spaces 
    
    properties
        x = 0          % x-coordinate of point
        y = 0       % y-coordinate of point
        z = 0          % z-coordinate of point
    end
    
    properties (Hidden)
        IndexBuilding       = -100
        IndexLevel          = -100
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

