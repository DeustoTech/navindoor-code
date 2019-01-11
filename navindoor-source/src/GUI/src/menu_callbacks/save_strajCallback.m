function save_strajCallback(object,event,h)
%SAVE_BUILDCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    [file,path] = uiputfile('*.mat','Save Workspace As');
    if ~isnumeric(path)
        list_box_straj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
        index_straj = list_box_straj.Value;
        itraj = h.trajectory_layer(index_straj).traj;

        if isempty(itraj)
           errordlg('You don''t have any trajectory.') 
           return
        end
        save(strcat(path,file),'itraj')
    end

end

