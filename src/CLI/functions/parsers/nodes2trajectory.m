function itrajectory = nodes2trajectory(nodes,varargin)
%NODES2TRAJECTORY Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
  
    addRequired(p,nodes)
    addOptional(p,'time_nodes',[])
    addOptional(p,'velocity_model','DampedOscillator')
    addOptional(p,'parameters_model',{})

    parse(p,nodes,varargin{:})
    
    time_nodes         =  p.Results.time_nodes;
    velocity_model     =  p.Results.velocity_model;
    parameters_model   =  p.Results.parameters_model;

    if strcmp(velocity_model,'DampedOscillator')
        itrajectory = DampedOscillator(nodes,parameters_model{:});
    end
    
end



