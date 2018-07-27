function path = smoothpath(tr)

    smooth_parameter = 0.015;
    x = smooth(1:length(tr.mt(:,1)),tr.mt(:,1),smooth_parameter);
    y = smooth(1:length(tr.mt(:,2)),tr.mt(:,2),smooth_parameter);

    path = mat2traj([x y]);

end
