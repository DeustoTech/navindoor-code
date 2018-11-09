classdef beacon<node

    properties
        frecuency = 1; % This property represents the refresh rate of the access point
        level = 0
    end
    
    methods
        %% constructor & settings
        function obj = beacon(r,varargin)
            %% Null element
            if nargin == 0
               return 
            end
            %% Parameters Assignment
            
            p = inputParser;
            addRequired(p,'r')
            addOptional(p,'frecuency',1)
            addOptional(p,'level',0)

            parse(p,r,varargin{:})
            %%
            obj.r           = p.Results.r;
            obj.frecuency   = p.Results.frecuency;
            obj.level       = p.Results.level;
        end
        
    end
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = beacon;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = beacon.empty(varargin{:});
             else
             % Use property default values
                z = repmat(beacon,varargin{:});
             end
          end
       end
    
end

