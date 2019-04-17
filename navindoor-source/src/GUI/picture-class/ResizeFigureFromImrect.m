function ResizeFigureFromImrect(pos,obj)
%RESIZEFIGURESW Summary of this function goes here
%   Detailed explanation goes here

    obj.Image.XData(1) = pos(1);
    obj.Image.XData(2) = pos(1) + pos(3);
    obj.Image.YData(1) = pos(2);
    obj.Image.YData(2) = pos(2) + pos(4);

    
    obj.XData = obj.Image.XData;
    obj.YData = obj.Image.YData;
end

