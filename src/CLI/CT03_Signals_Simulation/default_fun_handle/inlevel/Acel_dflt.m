function Aceleration  = Acel_dflt(index_inode,ilevel,itraj,parameters_sgn)
%BARO_DFLT  
    Aceleration = itraj.a(index_inode) + normrnd(0,parameters_sgn{1});
end
