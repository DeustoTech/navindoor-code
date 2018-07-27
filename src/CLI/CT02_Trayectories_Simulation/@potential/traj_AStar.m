function t = traj_AStar(pot,ni,nf)
    % ni: initial vertex
    % nf: final   vertex 
    [ ~ , xi ] = min(abs(ni.r(1)-pot.X(:,1)));
    [ ~ , yi ] = min(abs(ni.r(2)-pot.Y(1,:)));
    [ ~ , xf ] = min(abs(nf.r(1)-pot.X(:,1)));
    [ ~ , yf ] = min(abs(nf.r(2)-pot.Y(1,:)));    

    if pot.Z(xi,yi) == 1
        error('el punto inicial no puede estar en una pared')
    end

    if pot.Z(xf,yf) == 1
        error('el punto inicial no puede estar en una pared')
    end            

    nodefinal = node([xf,yf]);
    maxiter = 5000;

    mtcosto = -1*pot.Z ;
    mtcosto(xi,yi) = 1;

    posibles = zeros(1,5000,'node');
    posibles(1) =  node([xi,yi]);
    idx_posibles = 0;            
    idx_posibles_end = 1;

    addnode = [node([1 0]), node([ 0  1]), node([-1  0]), node([0 -1]) ];
    lenx = length(pot.Z(:,1));
    leny = length(pot.Z(1,:));

    new_nn = zeros(1,5000,'node');
    idx_new_nn = 0;

    for iter = 1:maxiter

       idx_posibles = idx_posibles + 1;

       distances = arrayfun(@(x) distn(nodefinal,x),posibles(idx_posibles:idx_posibles_end));
       [~,sort_idx] = sort(distances);
       posibles(idx_posibles:idx_posibles_end) = posibles(idx_posibles+sort_idx-1);

       inode = posibles(idx_posibles);
       for addn = addnode
           posible = inode+addn;
           if posible.r(1) < lenx && posible.r(2) < leny 
               if mtcosto(posible.r(1),posible.r(2)) == 0 
                    idx_new_nn = idx_new_nn + 1;
                    new_nn(idx_new_nn) = posible;
                    mtcosto(posible.r(1),posible.r(2)) = mtcosto(inode.r(1),inode.r(2)) + 1;
                    if posible == nodefinal
                        break
                    end 
               end
           end
       end
       if posible == nodefinal
            break
       end                

       if idx_posibles > idx_posibles_end
            error('los puntos ni y nf no se pueden unir')
       end

       if idx_new_nn ~= 0
            posibles(idx_posibles_end+1:idx_posibles_end+idx_new_nn) = new_nn(1:idx_new_nn);
            idx_posibles_end = idx_posibles_end + idx_new_nn ;
            idx_new_nn = 0;
       end

    end


    if posible == nodefinal
        costo = mtcosto(posible.r(1),posible.r(2));
        t = zeros(1,costo,'vertex');
        t(costo) = vertex([pot.X(nodefinal.r(1),1),pot.Y(1,nodefinal.r(2))]);
        costo = costo - 1;
        inode = nodefinal;
        while true 
            found = false;
            for addn = addnode
                new_nn = inode + addn;
                if mtcosto(new_nn.r(1),new_nn.r(2)) == costo
                    t(costo) = vertex([pot.X(new_nn.r(1),1),pot.Y(1,new_nn.r(2))]);
                    inode = new_nn;
                    costo = costo - 1;
                    found = true;
                    break
                end 
            end 

            if ~found
                error('no se encuentra camino')
            end
            if costo == 0
                break
            end 
        end
    end   
    t = traj(t);

end
