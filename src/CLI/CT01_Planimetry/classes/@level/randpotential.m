function result = randpotential(level,potential,class)
    if nargin < 3
        class = 'node';
    end
    Fz = griddedInterpolant(potential.X,potential.Y,potential.Z);
    maxiter = 100;
    for iter=1:maxiter
        n = rand(level,class);
        if Fz(n.r(1),n.r(2)) < 0.2
            result = n;
            return
        end
    end
    error('no se encuentra nodo');
end 