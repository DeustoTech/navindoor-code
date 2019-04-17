function btn_animation_trajectory(object,event,h)
    
    %%
    listbox_traj =  h.DirectAccess.Trajectory.Trajectories.listbox;
    index_traj   = listbox_traj.Value;
    %%

   if isempty(h.trajectory_layer(index_traj).traj)
        errordlg('You must generate the trajectory')
   else
        animation(h.trajectory_layer(index_traj).traj,'xx',20.0,'map',h.planimetry_layer.map)
   end

end
