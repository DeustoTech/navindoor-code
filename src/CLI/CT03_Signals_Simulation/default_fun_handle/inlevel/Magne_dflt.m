function north  = Magne_dflt(index_inode,ilevel,itraj,parameters_sgn)
%BARO_DFLT  
    % angle in level
    angle = itraj.angles(index_inode);
    % first quadrant
    angle = rem(angle,2*pi);
    
    north = ilevel.north - angle;
    north = north + normrnd(0,parameters_sgn{1});
end
