function newPosPicture(pos,obj)

    dx = obj.Image.XData(2) -  obj.Image.XData(1);
    dy = obj.Image.YData(2) -  obj.Image.YData(1);
   
    obj.Image.YData = [ pos(2) - 0.5*dx, pos(2) + 0.5*dy];
    obj.Image.XData = [ pos(1) - 0.5*dx, pos(1) + 0.5*dx];

end