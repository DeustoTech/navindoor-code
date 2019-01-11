function init_signal_processing(object,event,h)
%INIT_SIGNAL_PROCESSING Summary of this function goes here
%   Detailed explanation goes here

    %%
    listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');

    %%
   
   index = 0;
   idx = 0;
   String = {};
   some_traj = false;

   for ilabel = {h.trajectory_layer.label}
       index = index + 1;
       if ~isempty(h.trajectory_layer(index).traj)
           some_traj = true;
           if lensgn(h.trajectory_layer(index)) ~= 0 
               idx = idx + 1;
               String{idx} = ilabel{:};
               AvailableTraj(idx) = h.trajectory_layer(index);     
           end
       end
   end
   
   if ~exist('AvailableTraj','var')
      if some_traj
          errd = errordlg('You don''t have any trajectory with signal','','modal');
          waitfor(errd)
          h.iur_figure.Children(1).SelectedTab = h.iur_figure.Children(1).Children(3);
          init_signal_generation(object,event,h)
          return          
      else
          errd = errordlg('You don''t have any trajectory','','modal');
          waitfor(errd)
          h.iur_figure.Children(1).SelectedTab = h.iur_figure.Children(1).Children(2);
          init_trajectory(object,event,h)
          return
      end
   end
   
   h.AvailableTraj = AvailableTraj;
   listbox_straj.String =  String;
   
    %% Signals Aviable 
    for itrajlayer = h.AvailableTraj
        signals = zeros(0,0,'signal_layer');
        index = 0;
        for isignalayer = itrajlayer.signal_layer
           if ~isempty(isignalayer.signal)
               index  = index + 1;
               signals(index)= isignalayer;
           end
        end
        itrajlayer.aviable_signals = signals;
    end
    
    
    %% 
    
    update_processing_layer(h,'layer',true)
end


function number = lensgn(traj_layer)
    number = 0;
    for isignal = traj_layer.signal_layer
       if  ~isempty(isignal.signal)
           number = number + 1;
       end
    end
end
