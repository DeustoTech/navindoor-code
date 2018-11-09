function btn_generate_trajectory(object,event,h)
    
    listbox_levels =  findobj_figure(h.iur_figure,'Trajectory','Control','Levels','listbox');
    index_level = listbox_levels.Value;
    ilevel = h.planimetry_layer(1).building.levels(index_level);
    %%
    listbox_traj =  findobj_figure(h.iur_figure,'Trajectory','Supertraj','listbox');
    index_traj = listbox_traj.Value;
    %%

    
    ibuilding = h.planimetry_layer(1).building;
    ipoints   = h.trajectory_layer(index_traj).points;
    %%
    segments  = points2segments(ipoints,ibuilding);
    %%
    
    listbox     = findobj_figure(h.iur_figure,'Trajectory','By Floor:');
    strfun              = listbox.String{listbox.Value}(1:(end-2));
    byFloor_defaultGUI_string  = strfun;
    byFloor_defaultGUI  = str2func(strfun);

    listbox     = findobj_figure(h.iur_figure,'Trajectory','By Stairs:');
    strfun              = listbox.String{listbox.Value}(1:(end-2));
    byStairs_defaultGUI_string  = strfun;
    byStairs_defaultGUI  = str2func(strfun);
    
    listbox     = findobj_figure(h.iur_figure,'Trajectory','By Elevator:');
    strfun              = listbox.String{listbox.Value}(1:(end-2));
    byElevator_defaultGUI_string  = strfun;
    byElevator_defaultGUI  = str2func(strfun);
    %%
    listbox     = findobj_figure(h.iur_figure,'Trajectory','Foot To Reference trajectory','listbox');
    strfun              = listbox.String{listbox.Value}(1:(end-2));
    foot2Ref_defaultGUI_string  = strfun;    
    foot2Ref_defaultGUI  = str2func(strfun);    
    
    h.trajectory_layer(index_traj).traj = [];
    edit_generate = findobj_figure(h.iur_figure,'Trajectory','Info Objects','Generate:');
    edit_generate.BackgroundColor = [1 0 0];
    edit_generate.String = 'FALSE';
    set(h.iur_figure, 'pointer', 'watch')
    pause(0.5)
    try 
        
     h.trajectory_layer(index_traj).traj = traj(segments,'byFloorFcn',byFloor_defaultGUI,          ...
                   'byStairsFcn',byStairs_defaultGUI,       ...
                   'byElevatorsFcn',byElevator_defaultGUI,  ...
                   'foot2RefFcn',foot2Ref_defaultGUI);
    catch err 
        set(h.iur_figure, 'pointer', 'arrow')
        errordlg(err.message)
        return
    end
    set(h.iur_figure, 'pointer', 'arrow')

    
    %% set layer
    
        h.trajectory_layer(index_traj).segments         = segments;
        h.trajectory_layer(index_traj).points           = ipoints;
        h.trajectory_layer(index_traj).byFloorFcn       = byFloor_defaultGUI_string;
        h.trajectory_layer(index_traj).byStairsFcn      = byStairs_defaultGUI_string;
        h.trajectory_layer(index_traj).byElevatorsFcn   = byElevator_defaultGUI_string;
        h.trajectory_layer(index_traj).foot2RefFcn      = foot2Ref_defaultGUI_string;
        
    update_trajectory_layer(h)

end
