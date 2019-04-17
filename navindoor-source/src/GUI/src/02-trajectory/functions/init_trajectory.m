function init_trajectory(object,event,h)

   %% Generamos el build, dentro de la seccion 'Trajectory', no se puede modificar build

   GenerateMap(h.planimetry_layer);
   imap = h.planimetry_layer.map;
   
   Parent = h.DirectAccess.Trajectory.Axes;
   
   tab_trajectory       = findobj_figure(h.iur_figure,'tabgroup','Trajectory');

   listbox_level        = findobj_figure(tab_trajectory,'Levels'   ,'listbox');
   listbox_buildings    = findobj_figure(tab_trajectory,'Buildings','listbox');
   listbox_InOut        = findobj_figure(tab_trajectory,'In/Out'   ,'listbox');

   %%

   listbox_InOut.Value      = 1;

   delete(h.graphs_trajectory_layer.planimetry)
   exist_traj = false;
   if ~isempty(h.trajectory_layer)
      trajectories_listbox = findobj_figure(tab_trajectory,'Trajectories','listbox');
      index_traj = trajectories_listbox.Value;
      if ~isempty(h.trajectory_layer(index_traj).points)
          IndexBuilding = h.trajectory_layer(index_traj).points(end).IndexBuilding;
          IndexLevel    = h.trajectory_layer(index_traj).points(end).IndexLevel;
          if IndexBuilding ~= - 100
              exist_traj    = true;
              Indexs        = [listbox_buildings.Value,listbox_level.Value];
              Parent        = h.DirectAccess.Trajectory.Axes;
              h.graphs_trajectory_layer.planimetry = plot(imap,'Indexs',Indexs,'Parent',Parent,'doors',true);
              listbox_buildings.Enable = 'on';
              listbox_level.Enable     = 'on';
          else 
              h.graphs_trajectory_layer.planimetry = plot(imap,'Parent',Parent,'doors',true);
          end
      else
            h.graphs_trajectory_layer.planimetry = plot(imap,Parent,'doors',true);
      end
       
   else
      h.graphs_trajectory_layer.planimetry = plot(imap,Parent,'doors',true);
   end
   
   
   if ~exist_traj
       listbox_InOut.Value      = 2;
       listbox_buildings.Enable = 'off';
       listbox_level.Enable     = 'off';
   end
       %%
       number_of_buildings      = length(h.planimetry_layer.building_layers);
       if number_of_buildings ~= 0
           listbox_buildings.String = num2str((1:number_of_buildings)');
           listbox_buildings.Value = 1;
           ilayer = h.planimetry_layer.building_layers(1).level_layer;
           number_of_level = length(ilayer);
           if number_of_level ~= 0
               listbox_level.String = num2str((0:number_of_level-1)');
               listbox_level.Value = 1;
           end
       end       
   update_trajectory_layer(h)

end

