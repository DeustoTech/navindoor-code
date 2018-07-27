classdef elevator<door
    %DOOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        connections = []

    end
    
    methods
        %% constructor & settings
        function obj = elevator(r)
            
            obj=obj@door([0 0]);
            if nargin > 1
                obj=obj.r;
            elseif nargin > 0
                obj.r=r;
            end
        end
        
        
    end
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = elevator;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = elevator.empty(varargin{:});
             else
             % Use property default values
                z = repmat(elevator,varargin{:});
             end
          end
       end
    
end

