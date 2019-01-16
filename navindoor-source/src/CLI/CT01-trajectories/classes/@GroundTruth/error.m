function result = error(GrountTruth1,GrountTruth2,varargin)
%ERROR Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'GrountTruth1')
    addRequired(p,'GrountTruth2')
    addOptional(p,'frecuency',1)
    
    parse(p,GrountTruth1,GrountTruth2,varargin{:})
    
    frecuency = p.Results.frecuency;
    
    tf = min([GrountTruth1.timeline(end) GrountTruth2.timeline(end)]);

    timeline = 0:(1/frecuency):tf;
    
    
    rs1 = step(GrountTruth1,timeline);
    rs2 = step(GrountTruth2,timeline);

    result = sqrt(([rs1.x] - [rs2.x]).^2 + ([rs1.y] - [rs2.y]).^2 +([rs1.z] - [rs2.z]).^2);
    result = [timeline' result'];
    
end

