classdef trajectory_layer < handle
    %GEODATA Summary of this class goes here
    %   Detailed explanation goes here    
    properties
        traj 
         
        segments
        points
        %
        byFloorFcn
        byStairsFcn
        byElevatorsFcn
        %
        foot2RefFcn
        
        label = 'traj_001'
        signal_layer = signal_layer
        processing_layer = processing_layer
        %
        aviable_signals
        aviable_estimators
    end
    
    methods
 
        function unselect(obj)
            obj.vertexs = [ obj.vertexs obj.select_vertexs ];
            obj.select_vertexs = [];
        end
        
        function delete_traj(obj)
            obj.traj = [];
            for index = 1:length(obj.signal_layer)
                obj.signal_layer(index).signal = [];
            end
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

