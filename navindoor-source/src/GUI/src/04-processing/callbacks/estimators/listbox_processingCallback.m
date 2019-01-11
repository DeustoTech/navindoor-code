function listbox_processingCallback(object,event,h)
%LISTBOX_PROCESSINGCALLBACK Summary of this function goes here
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
         
         listbox_traj = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');
         listbox_esti = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Estimators','listbox');        
         
         defaultanswer={h.AvailableTraj(listbox_traj.Value).processing_layer(listbox_esti.Value).label};    
         
         numlines = 1;

         answer=inputdlg(prompt,name,numlines,defaultanswer);

         h.AvailableTraj(listbox_traj.Value).processing_layer(listbox_esti.Value).label = answer{:};

    end
    update_processing_layer(h)

end

