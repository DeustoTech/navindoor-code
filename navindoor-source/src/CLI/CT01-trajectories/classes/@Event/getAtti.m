function result = getAtti(iEvents)
%GETINERTIAL Summary of this function goes here
%   Detailed explanation goes here
    result = [];
    index = 0;
    for iEvent = iEvents
        index = index + 1;
        result(index).attx = iEvent.attx;
        result(index).atty = iEvent.atty;
        result(index).attz = iEvent.attz;
    end

end

