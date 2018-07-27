function north = Magne_inter_dflt(index_connection,istraj,ibuild,parameters)
%ACEL_INTER_DFLT Summary of this function goes here
%   Detailed explanation goes here
    % angle in level
    itraj = istraj.trajs(index_connection);
    ilevel = ibuild.levels(itraj.level+1);
    
    angle = itraj.angles(end);
    % first quadrant
    angle = rem(angle,2*pi);
    
    north = ilevel.north - angle;
    
    tline = istraj.dt_connections{index_connection}.t;
    magne = zeros(length(tline),1);
    for index=1:length(tline)
        magne(index) = north + normrnd(0,parameters{1});
    end
    
    north = array2table([tline , magne],'VariableNames',{'time ','north'});

end

