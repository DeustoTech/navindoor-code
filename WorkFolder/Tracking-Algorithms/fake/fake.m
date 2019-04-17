function mt_trajectory = fake(signals,ibuilding,itraj)
    % description: fakes algoritm 
       
    tline = itraj.GroundTruths.Ref.timeline;
    mt_trajectory = zeros(length(tline),4);
    index = 0;
    for t = tline
        index = index + 1;
        result = step(itraj,t);
        mt_trajectory(index,1) = result.x + 10*(0.5-rand);
        mt_trajectory(index,2) = result.y + 10*(0.5-rand);
        mt_trajectory(index,3) = result.z;
        mt_trajectory(index,4) = result.t;
    end

end

