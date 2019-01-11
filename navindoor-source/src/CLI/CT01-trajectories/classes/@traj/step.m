function result = step(itraj,t,varargin)
%STEP Summary of this function goes here
%   Detailed explanation goes here

    p = inputParser;
    addRequired(p,'itraj')
    addRequired(p,'t')
    addOptional(p,'type','Ref')

    parse(p,itraj,t,varargin{:})
        
    type = p.Results.type;
    
    switch type
        case 'Ref'
            result = step(itraj.GroundTruths.Ref,t);
        case 'CoM'
            result = step(itraj.GroundTruths.CoM,t);
        case 'foot'
            result = step(itraj.GroundTruths.foot,t);

    end
end

