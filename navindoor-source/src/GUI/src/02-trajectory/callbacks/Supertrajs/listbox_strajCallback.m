function listbox_strajCallback(object,event,h)
%LISTBOX_STRAJCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    
    
    persistent chk
    if isempty(chk)
          chk = 1;
          pause(0.25); %Add a delay to distinguish single click from a double click
          if chk == 1
              chk = [];
          end
    else
        chk = [];
         prompt={'Enter the name of trajectory layer'};
         name='Input for Peaks function';
         
         listbox_traj = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');

         defaultanswer={h.trajectory_layer(listbox_traj.Value).label};    
         numlines = 1;

         answer=inputdlg(prompt,name,numlines,defaultanswer);

         h.trajectory_layer(listbox_traj.Value).label = answer{:};
    end
    
    update_trajectory_layer(h);

end

