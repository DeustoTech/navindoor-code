function boolean = crossdoors(iwall,traj)
    [cro, r] = cross(iwall,traj);
    if ~cro
            boolean = false;
    else
            boolean = true;
            for idoor=iwall.doors
                if norm(idoor.r(1:2) - r(1:2)) < idoor.width
                    boolean = false;
                    return
                end
            end
    end
end
