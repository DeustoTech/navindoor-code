function RefGT = mat2RefGT(mat,varargin)
%MAT2TRAJ Summary of this function goes here
%   Detailed explanation goes here

    p = inputParser;
    addRequired(p,'mat')
    addOptional(p,'frecuency',1)
    
    parse(p,mat,varargin{:})
    
    [nrow,ncol] = size(mat);
    %
    dt = mat(2,4) - mat(1,4);
    %
    vx = gradient(mat(:,1),dt);
    vy = gradient(mat(:,2),dt);
    vz = gradient(mat(:,3),dt);

    Events = zeros(1,nrow,'Event');
    
    for irow = 1:nrow
        Events(irow).x = mat(irow,1);
        Events(irow).y = mat(irow,2);
        Events(irow).z = mat(irow,3);
        Events(irow).vx = vx(irow);
        Events(irow).vy = vy(irow);
        Events(irow).vz = vz(irow);
    end
    
    RefGT = GroundTruth;
    RefGT.timeline = mat(:,4)';
    RefGT.type = 'Ref';
    RefGT.Events = Events;
    RefGT.frecuency = 1/dt;

end

