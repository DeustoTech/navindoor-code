function boolean = trajoflevel(traj,level)
   %% TRAJOFLEVEL 
   % Verifies that it is a path allowed within a level
   % INPUTS: Trayectory(TRAJ), Level(LEVEL)
   % OUTPUTS: RESULT(BOOLEAN) 
   %
   % EXAMPLE
   % =======
   % clear
   % % Creamos una trayectoria 
   % x = 0:0.1:50;
   % y = 0.05*x.^2;
   % itraj = mat2traj([x' y']);
   % % Creamos un nivel
   % ilevel = level;
   % ilevel.walls = wall([node([0 25]) node([50 25])]);
   % % comprobamos si se cruzan 
   % trajoflevel(itraj,ilevel)
   % % Retorna falso, debido a que la trayectoria 
   % % no es compatible con el nivel.
   % plot(ilevel)
   % hold on
   % plot(itraj)
   % 
   
   boolean = true;

   for index=1:traj.len-1
       ni = traj.nodes(index);
       nf = traj.nodes(index+1);
       twall = wall([ni,nf]);
       for lwall=level.walls
           % check if any part of the path crosses with any wall
           if crossdoors(lwall,twall)
              boolean = false;
              return
           end
       end
   end           
end
