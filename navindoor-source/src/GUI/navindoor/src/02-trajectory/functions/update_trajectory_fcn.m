function update_trajectory_fcn(object,event,h)
%UPDATE_TRAJECTORY_FCN Summary of this function goes here
%   Detailed explanation goes here
%% Foot Models Simulation
list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot Models Simulation','By Floor:');
result =  what('Models-Trajectory-Simulation/foot_velocity/byFloor');
if length(result.m) < list_footmodels.Value
    list_footmodels.Value = 1;
end
list_footmodels.String =result.m;
%
list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot Models Simulation','By Elevator:');
result =  what('Models-Trajectory-Simulation/foot_velocity/byElevator');
if length(result.m) < list_footmodels.Value
    list_footmodels.Value = 1;
end
list_footmodels.String =result.m;
%
list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot Models Simulation','By Stairs:');
result =  what('Models-Trajectory-Simulation/foot_velocity/byStairs');
if length(result.m) < list_footmodels.Value
    list_footmodels.Value = 1;
end
list_footmodels.String =result.m;


list_footmodels = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Foot To Reference trajectory','listbox');
result =  what('Models-Trajectory-Simulation/foot2Ref');
if length(result.m) < list_footmodels.Value
    list_footmodels.Value = 1;
end
list_footmodels.String =result.m;

end

