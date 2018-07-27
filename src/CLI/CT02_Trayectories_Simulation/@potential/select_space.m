function new_pot=select_space(pot,ni)
               % ni: initial vertex
    % nf: final   vertex 
    [ ~ , xi ] = min(abs(ni.r(1)-pot.X(:,1)));
    [ ~ , yi ] = min(abs(ni.r(2)-pot.Y(1,:)));

    if pot.Z(xi,yi) == 1
        error('el punto inicial no puede estar en una pared')
    end

    maxiter = 5000;

    new_pot = pot.X*0 + 1 ;
    new_pot(xi,yi) = 0;
    posibles = node([xi,yi]);

    addnode = [node([1 0]), node([ 0  1]), node([-1  0]), node([0 -1]) ];
    lenx = length(pot.Z(:,1));
    leny = length(pot.Z(1,:));
    for iter = 1:maxiter
       new_nn = zeros(1,5000,'node');
       index_new_nn = 0;
       for inode = posibles
           for addn = addnode
               posiblenode = inode+addn;
               if posiblenode.r(1) < lenx && posiblenode.r(2) < leny ...
                  && posiblenode.r(1) > 0 && posiblenode.r(2) > 0
                   if pot.Z(posiblenode.r(1),posiblenode.r(2)) == 0 && ...
                      new_pot(posiblenode.r(1),posiblenode.r(2)) == 1
                        index_new_nn = index_new_nn + 1;
                        new_nn(index_new_nn) = posiblenode;
                        new_pot(posiblenode.r(1),posiblenode.r(2)) = 0;
                   end
               end
           end

       end
       posibles = new_nn(1:index_new_nn);
       if isempty(posibles)
            new_pot = potential(pot.X,pot.Y,new_pot);
            return
       end 
    end

end
