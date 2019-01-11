function BaroValue = Event2Barometer_default(position,params)
%EVENT2BAROMETER_DEFAULT Summary of this function goes here
%   Detailed explanation goes here
    BaroValue = hight2pressure(position.z) + normrnd(0,0.05);
    
end

