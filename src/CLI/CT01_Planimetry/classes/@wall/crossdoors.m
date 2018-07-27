function boolean = crossdoors(wall,traj)
    [cro, r] = cross(wall,traj);
    if ~cro
            boolean = false;
    else
            boolean = true;
            for idoor=wall.doors
                if distn(idoor,r) < idoor.width
                    boolean = false;
                    return
                end
            end
    end
end