function update_trajectory_layer(h)
%UPDATE_TRAJECTORY_LAYER Summary of this function goes here
%   Detailed explanation goes here
    
list_box_levels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Levels','listbox');
index_level = list_box_levels.Value;

list_box_straj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
index_straj = list_box_straj.Value;
      
%% Velocity


%% Info Objects
has_velocity = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Info Objects','Has Velocity:');

if h.trajectory_layer(index_straj).supertraj.dt == 0 
    has_velocity.BackgroundColor = [1 0 0];
    has_velocity.String = 'FALSE';
    
else
    has_velocity.BackgroundColor = [0 1 0.5];
    has_velocity.String = 'TRUE';
end


edit_label = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Info Objects','Label:');
edit_label.String = h.trajectory_layer(index_straj).supertraj.label;


% h.trajectory_layer(index_straj).supertraj.label = object.String;
% h.trajectory_layer(index_straj).label = object.String;
%% Supertraj
supetraj_panel = findobj_figure(h.iur_figure,'Trajectory','Supertraj');
listbox = findobj(supetraj_panel,'Style','listbox');
listbox.String =  {h.trajectory_layer.label};

%% Graphs Panel
axes_traj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Graphs','axes');
plot(h.trajectory_layer(index_straj),index_level,axes_traj);

end

