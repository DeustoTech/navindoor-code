function pot=normalize(pot,varargin)

    new_Z=pot.Z > 0.5;
    pot = potential(pot.X,pot.Y,double(new_Z));
end   