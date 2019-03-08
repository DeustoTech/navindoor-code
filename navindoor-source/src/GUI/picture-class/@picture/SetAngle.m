function SetAngle(obj,angle)
%SETANGLE Summary of this function goes here
%   Detailed explanation goes here
obj.Angle = angle;

CData = obj.CData;
obj.Image.CData = imrotate(CData,angle);
ResizeFigureFromCData(obj)
end

