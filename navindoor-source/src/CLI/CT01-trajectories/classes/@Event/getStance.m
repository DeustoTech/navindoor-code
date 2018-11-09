function result = getStance(iEvents)
%GETINERTIAL Summary of this function goes here
%   Detailed explanation goes here
    result = [];
    index = 0;
    
    result = zeros(length(iEvents),1);
    for iEvent = iEvents
        index = index + 1;
        result(index) = iEvent.Stance;
    end

end

