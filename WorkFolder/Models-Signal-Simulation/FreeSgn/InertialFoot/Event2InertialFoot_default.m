function inertialvalues = Event2InertialFoot_default(position,params)
%EVENT2INERTIALFOOT_DEFAULT Summary of this function goes here
%   Detailed explanation goes here
inertialvalues = [position.ax position.ay position.az position.gyrox position.gyroy position.gyroz]';
end

