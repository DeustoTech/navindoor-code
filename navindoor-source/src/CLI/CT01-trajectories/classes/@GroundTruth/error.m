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
    result = zeros(1,length(timeline));
    
    index = 0;
    for t = timeline
       index = index +1;
       rs1 = step(GrountTruth1,t);
       rs2 = step(GrountTruth2,t);
       result(index) = (rs1.x - rs2.x)^2 + (rs1.y - rs2.y)^2 + (rs1.z - rs2.z)^2;
       result(index) = sqrt(result(index));
    end
    
    result = [timeline' result'];
    
end

