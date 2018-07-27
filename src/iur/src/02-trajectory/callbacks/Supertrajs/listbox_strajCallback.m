function listbox_strajCallback(object,event,h)
%LISTBOX_STRAJCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    axes_trajectory = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Graphs','axes');
    delete(axes_trajectory.Children);
    
    listbox_level = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Control','Levels','listbox');
    index_level = listbox_level.Value;
    plot(h.planimetry_layer,index_level,axes_trajectory);
    
    persistent chk
    if isempty(chk)
          chk = 1;
          pause(0.25); %Add a delay to distinguish single click from a double click
          if chk == 1
              chk = [];
          end
    else
        chk = [];
        listbox_strajs = findobj_figure(h.iur_figure,'Trajectory','Supertraj','listbox');
        index_strajs = listbox_strajs.Value;
        
        straj = h.trajectory_layer(index_strajs).supertraj;
        if ~isempty(straj)
            too = TableOfObjects(straj);
            waitfor(too.figure)
            % deberia ser automatizado por ahora se queda asi 
            h.trajectory_layer(index_strajs).label = straj.label;
        end
    end
    
    update_trajectory_layer(h);

end

