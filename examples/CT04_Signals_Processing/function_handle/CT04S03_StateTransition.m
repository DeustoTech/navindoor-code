function x_new = CT04S03_StateTransition(x,dt)
%STATETRANSITION 
% 
        % x     y    vx    vy   ax       ay
        % ----------------------------------------------
    F = [ 1     0    dt    0    0.5*dt^2   0        ; ... % | x
          0     1    0     dt   0          0.5*dt^2 ; ... % | y
          0     0    1     0    dt         0        ; ... % | vx
          0     0    1     0    dt         0        ; ... % | vy
          0     0    0     0    1          0        ; ... % | ax
          0     0    0     0    0          1        ];... % | ay
      
    x_new = F*x;
end