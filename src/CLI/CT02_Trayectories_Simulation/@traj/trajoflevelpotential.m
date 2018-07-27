function boolean = trajoflevelpotential(traj,potential)
   %%  trajectory tester with potential
   % INPUTS: Trayectory(TRAJ), Level(LEVEL)
   % OUTPUTS: RESULT(BOOLEAN)            
   % REQUIREMENTS: need that level have potential
   %
   % check if any part of the path have a potential value grather
   % that 0.15.
   boolean = true;
   for index=1:traj.len-1
       ni = traj.nodes(index);
       nf = traj.nodes(index+1);
       twall = wall([ni,nf]);

       x = twall.intervals.xmin:potential.precision*0.05:twall.intervals.xmax;
       y = twall.m*x+twall.n;
       Z = griddedInterpolant(potential.X,potential.Y,potential.Z,'cubic');
       result = Z(x',y');
       if max(result) > 0.1
           boolean = false;
       end
   end

end      