function btn_animation_trajectory(object,event,h)
    
    listbox_levels =  findobj_figure(h.iur_figure,'Trajectory','Levels','listbox');
    index_level = listbox_levels.Value;
    ilevel = h.planimetry_layer(1).building.levels(index_level);
    %%
    listbox_traj =  findobj_figure(h.iur_figure,'Trajectory','Supertraj','listbox');
    index_traj = listbox_traj.Value;
    %%

   if isempty(h.trajectory_layer(index_traj).traj)
        errordlg('You must generate the trajectory')
   else
        animation(h.trajectory_layer(index_traj).traj,'xx',10.0,'building',h.planimetry_layer(1).building)
   end

end
