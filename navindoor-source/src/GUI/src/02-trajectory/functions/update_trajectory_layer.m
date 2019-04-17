function update_trajectory_layer(h,varargin)

% Actualiza los elemntos de GUI de la seccion de la trayectoria 
% Existe algunos parmateros por defecto para cuando sola tenga que actualizar
% ciertos elementos 

p = inputParser;

addRequired(p,'h')
addOptional(p,'layer',false)
addOptional(p,'onlyclick',false)


parse(p,h,varargin{:})

layer = p.Results.layer;
onlyclick =  p.Results.onlyclick;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Init
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
list_box_straj = h.DirectAccess.Trajectory.Trajectories.listbox;
index_straj = list_box_straj.Value;
      
if ~onlyclick
    %% By Floor 
    list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot Models Simulation','By Floor:');
    result =  what(fullfile(h.navindoor_path,'WorkFolder','Models-Trajectory-Simulation','foot_velocity','byFloor'));
    list_footmodels.String =result.m;

    if layer && ~isempty(h.trajectory_layer(index_straj).byFloorFcn)
        byfloor = [h.trajectory_layer(index_straj).byFloorFcn,'.m'];
        [~ , index ] = ismember(byfloor,list_footmodels.String);
        list_footmodels.Value = index;
    end
    %% By  Elevators
    list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot Models Simulation','By Elevator:');
    result =  what(fullfile(h.navindoor_path,'WorkFolder','Models-Trajectory-Simulation','foot_velocity','byElevator'));
    list_footmodels.String =result.m;
    if layer && ~isempty(h.trajectory_layer(index_straj).byElevatorsFcn)
        byElevatorsFcn = [h.trajectory_layer(index_straj).byElevatorsFcn,'.m'];
        [~ , index ] = ismember(byElevatorsFcn,list_footmodels.String);
        list_footmodels.Value = index;
    end
    %% By Stairs
    list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot Models Simulation','By Stairs:');
    result =  what(fullfile(h.navindoor_path,'WorkFolder','Models-Trajectory-Simulation','foot_velocity','byStairs'));
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

    %% Supertraj

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
    list_box_straj.String = String;
end

%% Graphs Panel
InOutListBox    = h.DirectAccess.Trajectory.Navigation.InOut;
InOut           = InOutListBox.String{InOutListBox.Value};

switch InOut
    case '--In--'
        IndexLevel      = h.DirectAccess.Trajectory.Navigation.Levels.Value;
        IndexBuilding   = h.DirectAccess.Trajectory.Navigation.Buildings.Value;
    case '-Out-'
        IndexLevel      = -100; % su valor por defecto - punto en el exterior
        IndexBuilding   = -100; % su valor por defecto - punto en el exterior        
end

Indexs = [IndexBuilding,IndexLevel];
axes   = h.DirectAccess.Trajectory.Axes;

delete(h.graphs_trajectory_layer.trajectory)
if ~isempty(h.trajectory_layer)
    h.graphs_trajectory_layer.trajectory = plot(h.trajectory_layer(index_straj),Indexs,axes);
end


end

