function new_walls=scale(walls,x,y)
    new_walls=arrayfun(@(var)scale1(var,x,y),walls);
    function nwall=scale1(old_wall,x,y)
        nwall = wall(scale(old_wall.nodes,x,y));
        if ~isempty(nwall.doors)
            nwall.doors = scale(old_wall.doors,x,y);
        end
    end
end