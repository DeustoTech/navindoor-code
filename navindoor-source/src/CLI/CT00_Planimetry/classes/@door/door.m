classdef door<node
    %DOOR, navindoor class that rperesents the door in wall
    properties
        width {mustBePositive}      = 2; % Width of door 
    end
    
    methods
        %% constructor & settings
        function obj = door(r,varargin)
            %% Null element
            if nargin == 0
               return 
            end
            %% Parameters Assignment
            
            % Cacth default values of father class
            default_node = node;

            p = inputParser;
            addRequired(p,'r')
            addOptional(p,'width',2)

            parse(p,r,varargin{:})
            obj.r     = p.Results.r;
            obj.width = p.Results.width;

        end
        
    end
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = door;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = door.empty(varargin{:});
             else
             % Use property default values
                z = repmat(door,varargin{:});
             end
          end
       end
    
end

