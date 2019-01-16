function listbox_signalCallback(object,event,h)
%LISTBOX_SIGNALCALLBACK Summary of this function goes here
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
         
         listbox_traj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
         listbox_sign = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');
         defaultanswer={h.AvailableTraj(listbox_traj.Value).signal_layer(listbox_sign.Value).label};    
         numlines = 1;

         answer=inputdlg(prompt,name,numlines,defaultanswer);

         h.AvailableTraj(listbox_traj.Value).signal_layer(listbox_sign.Value).label = answer{:};
         if  ~isempty(h.AvailableTraj(listbox_traj.Value).signal_layer(listbox_sign.Value).signal)
            h.AvailableTraj(listbox_traj.Value).signal_layer(listbox_sign.Value).signal.label = answer{:};
         end
    end
    
    update_signal_layer(h,'layer',true);

    
end

