function result = traj_potential(obj,x0,y0,vx0,vy0,steps)
%% TRAJ_POTENTIAL 
% Function able to create a trayectory inside a level class using the
% pseudopotential based in walls and doors.
% INPUTS:
%   - potential 
%   - x0
%   - y0
%   - vx0 
%   - vy0 
%   - steps
% 
% OUTPUTS:
%
% EXAMPLE:
% 
%
% SEE ALSO:
    dt = 1;
    nodes = zeros(1,steps,'node');
    mt_velocity = zeros(2,steps);
    vx = vx0; x = x0;
    vy = vy0; y = y0;
    Vdx = griddedInterpolant(obj.X,obj.Y,obj.dx);
    Vdy = griddedInterpolant(obj.X,obj.Y,obj.dy);

    for n=1:steps
           x = vx*dt + x;
           y = vy*dt + y;

           nodes(n) = node([ x y ]);
           vx = Vdx(x,y)*dt + vx;
           vy = Vdy(x,y)*dt + vy;
           mt_velocity(:,n) = [vx vy]; 
    end

    result.trayectory = traj(nodes);
    result.velocity = mt_velocity;

end 
