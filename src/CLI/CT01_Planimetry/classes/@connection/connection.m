classdef connection< wall
    %connection Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        %% constructor & settings
        function obj = connection(nodes)
            if exist('nodes','var')
            obj.nodes = nodes;
            end
        end
        
    end
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = connection;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = connection.empty(varargin{:});
             else
             % Use property default values
                z = repmat(connection,varargin{:});
             end
          end
       end
    
end

