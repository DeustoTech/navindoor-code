function Giro  = Giro_dflt(index_inode,ilevel,itraj,parameters_sgn)
%BARO_DFLT  
    Giro = itraj.a(index_inode) + normrnd(0,parameters_sgn{1});

end
