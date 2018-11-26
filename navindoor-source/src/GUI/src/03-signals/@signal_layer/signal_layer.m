classdef signal_layer
    %SIGNAL_LAYER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        signal 
        type
        frecuency
        beacons
        Event2msFcn
        label = 'sgn_001'
    end
    
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = signal_layer;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = signal_layer.empty(varargin{:});
             else
             % Use property default values
                z = repmat(signal_layer,varargin{:});
             end
          end
       end
end

