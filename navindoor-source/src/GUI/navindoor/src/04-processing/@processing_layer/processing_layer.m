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
    
end

