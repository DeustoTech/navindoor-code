classdef trajectory_layer < handle
    %GEODATA Summary of this class goes here
    %   Detailed explanation goes here    
    properties
        supertraj = supertraj
        vertexs
        select_vertexs
        connections 
        label = 'straj_001'
        signal_layer = signal_layer
        processing_layer = processing_layer
        aviable_signals
        aviable_estimators
    end
    
    methods
 
        function unselect(obj)
            obj.vertexs = [ obj.vertexs obj.select_vertexs ];
            obj.select_vertexs = [];
        end
    end
    
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = trajectory_layer;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = trajectory_layer.empty(varargin{:});
             else
             % Use property default values
                z = repmat(trajectory_layer,varargin{:});
             end
          end
       end
end

