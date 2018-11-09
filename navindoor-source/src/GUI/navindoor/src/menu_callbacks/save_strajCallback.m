function save_strajCallback(object,event,h)
%SAVE_BUILDCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    [file,path] = uiputfile('*.mat','Save Workspace As');
    if ~isnumeric(path)
        list_box_straj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
        index_straj = list_box_straj.Value;
        
        if h.trajectory_layer(index_straj).supertraj.dt == 0 
            warndlg('You are saving the trajectory without velocity assosiate')
        end
        
        straj = h.trajectory_layer.supertraj;
        save(strcat(path,file),'straj')
    end

end

