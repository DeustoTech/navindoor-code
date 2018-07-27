function points = reducepath(t,iters,level,potential)
    if nargin < 4
        precision = 0.2;
        potential = potlevel(level,precision);
    end
    %% smooth path in level
    P = t.mt';
    [n,m] = size(P);
    clearvars n;
    l = zeros(m,1);
    for k=2:m
        l(k)=norm(P(:,k)-P(:,k-1)) + l(k-1); % find all of the straight-line distances
    end
    l_init = l(m);
    iter = 1;
    while iter <= iters
        s1 = rand(1,1)*l(m); 
        s2 = rand(1,1)*l(m); 
        if s2 < s1
            temps = s1;
            s1 = s2;
            s2 = temps;
        end
        for k=2:m
            if s1 < l(k)
                i = k - 1;
                break;
            end
        end
        for k=(i+1):m
            if s2 < l(k)
                j = k - 1;
                break;
            end
        end
        if (j <= i)
            iter = iter + 1;
            continue;
        end
        t1 = (s1 - l(i))/(l(i+1)-l(i));
        gamma1 = (1 - t1)*P(:,i) + t1*P(:,i+1);
        t2 = (s2 - l(j))/(l(j+1)-l(j));
        gamma2 = (1 - t2)*P(:,j) + t2*P(:,j+1);
        t=traj([node(gamma1) node(gamma2)]);
        col = ~(trajoflevelpotential(t,potential));
        if col == 1
            iter = iter + 1;
            continue;
        end
        newP = [P(:,1:i) gamma1 gamma2 P(:,j+1:m)];
        clearvars P;
        P = newP;
        [n,m] = size(P);
        clearvars n;
        l = zeros(m,1);
        for k=2:m
            l(k)=norm(P(:,k)-P(:,k-1)) + l(k-1);
        end
        iter = iter + 1;
    end

    points = mat2traj(P');

    points = normtraj(traj(points.nodes),t.step);

end 
