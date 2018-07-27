function P  = Baro_dflt(index_inode,ilevel,itraj,parameters_sgn)
%BARO_DFLT  
    hight = ilevel.high; % m
    P = hight2pressure(hight) + normrnd(0,parameters_sgn{1}) ;
end
