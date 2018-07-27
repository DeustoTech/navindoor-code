function t = random_traj_potential(obj,x0,y0,steps,number_traj)
% Generation of random traj inside potential field
    v0 = obj.presicion ;
    t = traj();
    for rep = 1:number_traj
        theta = randi(4)*(2*pi)/4;
        vx0 = v0*sin(theta+0.15);vy0 = v0*cos(theta+0.15);
        evolution = traj_potential(obj,x0,y0,vx0,vy0,steps);
        t = t + evolution.trayectory;
        vx = evolution.velocity(1,end);
        vy = evolution.velocity(2,end);
        v0 = sqrt(vx^2 + vy^2);
        x0 = t.mt(end,1);
        y0 = t.mt(end,2);
    end
end
