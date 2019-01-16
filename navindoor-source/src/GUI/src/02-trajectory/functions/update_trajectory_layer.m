function update_trajectory_layer(h,varargin)
%UPDATE_TRAJECTORY_LAYER Summary of this function goes here
%   Detailed explanation goes here
    
p = inputParser;

addRequired(p,'h')
addOptional(p,'layer',false)
addOptional(p,'onlyclick',false)


parse(p,h,varargin{:})

layer = p.Results.layer;

onlyclick =  p.Results.onlyclick;

%list_box_levels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Levels','listbox');
list_box_levels = h.iur_figure.Children(1).Children(2).Children(2).Children(1).Children;
index_level = list_box_levels.Value;

%list_box_straj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
list_box_straj = h.iur_figure.Children(1).Children(2).Children(4).Children(3);
index_straj = list_box_straj.Value;
      
if ~onlyclick
    %% Foot Models Simulation
    list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot Models Simulation','By Floor:');
    result =  what('Models-Trajectory-Simulation/foot_velocity/byFloor');
    list_footmodels.String =result.m;

    if layer && ~isempty(h.trajectory_layer(index_straj).byFloorFcn)
        byfloor = [h.trajectory_layer(index_straj).byFloorFcn,'.m'];
        [~ , index ] = ismember(byfloor,list_footmodels.String);
        list_footmodels.Value = index;
    end
    %
    list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot Models Simulation','By Elevator:');
    result =  what('Models-Trajectory-Simulation/foot_velocity/byElevator');
    list_footmodels.String =result.m;

    if layer && ~isempty(h.trajectory_layer(index_straj).byElevatorsFcn)
        byElevatorsFcn = [h.trajectory_layer(index_straj).byElevatorsFcn,'.m'];
        [~ , index ] = ismember(byElevatorsFcn,list_footmodels.String);
        list_footmodels.Value = index;
    end

    %
    list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot Models Simulation','By Stairs:');
    result =  what('Models-Trajectory-Simulation/foot_velocity/byStairs');
    list_footmodels.String =result.m;

    if layer && ~isempty(h.trajectory_layer(index_straj).byStairsFcn)
        byStairsFcn = [h.trajectory_layer(index_straj).byStairsFcn,'.m'];
        [~ , index ] = ismember(byStairsFcn,list_footmodels.String);
        list_footmodels.Value = index;
    end
    %% Foot to Ref Models Simulation
    list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot To Reference trajectory','listbox');
    result =  what('Models-Trajectory-Simulation/foot2Ref');
    list_footmodels.String =result.m;


    if layer && ~isempty(h.trajectory_layer(index_straj).foot2RefFcn)
        foot2RefFcn = [h.trajectory_layer(index_straj).foot2RefFcn,'.m'];
        [~ , index ] = ismember(foot2RefFcn,list_footmodels.String);
        list_footmodels.Value = index;
    end

    %% Info Objects
    % Generate = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Info Objects','Generate:');
    % 
    % if isempty(h.trajectory_layer(index_straj).traj)
    %     Generate.BackgroundColor = [1 0 0];
    %     Generate.String = 'FALSE';
    %     
    % else
    %     Generate.BackgroundColor = [0 1 0.5];
    %     Generate.String = 'TRUE';
    % end
    % 
    % 
    % edit_label = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Info Objects','Label:');
    % edit_label.String = h.trajectory_layer(index_straj).label;


    % h.trajectory_layer(index_straj).supertraj.label = object.String;
    % h.trajectory_layer(index_straj).label = object.String;
    %% Supertraj
    supetraj_panel = findobj_figure(h.iur_figure,'Trajectory','Supertraj');
    listbox = findobj(supetraj_panel,'Style','listbox');

    String = {};
    index = 0;
    for ilabel = {h.trajectory_layer.label}
        index = index + 1;
        if ~isempty(h.trajectory_layer(index).traj)
            String{index} = ['<HTML><FONT color="2ecc39">',ilabel{:},' - OK </FONT></HTML>'];
        else
            String{index} = ['<HTML><FONT color="FF0000">',ilabel{:},' - NONE </FONT></HTML>'];
        end
    end
    listbox.String = String;
end

%% Graphs Panel
%axes_traj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Graphs','axes');
axes_traj = h.iur_figure.Children(1).Children(2).Children(2).Children(2);
height = h.planimetry_layer(index_level).height;
plot(h.trajectory_layer(index_straj),height,axes_traj);


end

