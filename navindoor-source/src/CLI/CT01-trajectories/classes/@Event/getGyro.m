function result = getGyro(iEvents)
%GETINERTIAL Summary of this function goes here
%   Detailed explanation goes here
    result = [];
    index = 0;
    for iEvent = iEvents
        index = index + 1;
        result(index).gyrox = iEvent.gyrox;
        result(index).gyroy = iEvent.gyroy;
        result(index).gyroz = iEvent.gyroz;
    end

end

