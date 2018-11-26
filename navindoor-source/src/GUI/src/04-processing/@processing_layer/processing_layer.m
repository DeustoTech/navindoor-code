classdef processing_layer
    %PROCESSING_LAYER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        label = 'estimator_001'
        AlgorithmFcn 
        ParamsFcn
        Signals 
        %%
        traj_reference
        traj_result
        error
        mt
        RefGT_estimate
        ecdf
    end
    
    
        methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = processing_layer;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = processing_layer.empty(varargin{:});
             else
             % Use property default values
                z = repmat(processing_layer,varargin{:});
             end
          end
       end
end

