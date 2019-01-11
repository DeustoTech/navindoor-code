classdef ms < Event
    %MS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        values
    end
    
    properties (Hidden)
        indexs_beacons
    end
    
    methods (Static)
      function z = zeros(varargin)
         if (nargin == 0)
         % For zeros('Event')
            z = ms;
         elseif any([varargin{:}] <= 0)
         % For zeros with any dimension <= 0   
            z = ms.empty(varargin{:});
         else
         % For zeros(m,n,...,'Color')
         % Use property default values
            z = repmat(ms,varargin{:});
         end
      end
    end
end

