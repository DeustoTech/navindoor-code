function init_trajectory(object,event,h)
%   Detailed explanation goes here

   %% Generamos el build, dentro de la seccion 'Trajectory', no se puede modificar build
   h.planimetry_layer(1).building = generate_build(h.planimetry_layer);
   
   tab_trajectory = findobj_figure(h.iur_figure,'tabgroup','Trajectory');

   listbox_level = findobj_figure(tab_trajectory,'Control','Levels','listbox');
   
   traj_axes = findobj_figure(tab_trajectory,'Graphs','axes');
   
   number_of_levels = length(h.planimetry_layer);
   listbox_level.String = num2str((0:number_of_levels-1)');
   %% Mostramos la plnaimetry, en la gráfica 
   index_level = listbox_level.Value;
   traj_axes.XLim =  h.planimetry_layer(1).XLim;
   traj_axes.YLim =  h.planimetry_layer(1).YLim;
   plot(h.planimetry_layer,index_level,traj_axes);
   
   
   planimetry_axes = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Graphs','axes');
   traj_axes.XLim = planimetry_axes.XLim;
   traj_axes.YLim = planimetry_axes.YLim; 

   
   update_trajectory_layer(h,'layer',true);

  

end

