function init_signal_generation(object,event,h)
%   Detailed explanation goes here

   h.planimetry_layer(1).building = generate_build(h.planimetry_layer);

   listbox_strajs = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
   supetraj_panel = findobj_figure(h.iur_figure,'Signal Generation','Supertraj');
   
   listbox = findobj(supetraj_panel,'Style','listbox');
   
   index = 0;
   idx = 0;
   String = {};
   for ilabel = {h.trajectory_layer.label}
       index = index + 1;
       if ~isempty(h.trajectory_layer(index).traj)
           idx = idx + 1;
            String{idx} = ilabel{:};
            AvailableTraj(idx) = h.trajectory_layer(index);
       end
   end
   if ~exist('AvailableTraj','var')
      errd = errordlg('You don''t have any trajectory','','modal');
      waitfor(errd)
      h.iur_figure.Children(1).SelectedTab = h.iur_figure.Children(1).Children(2);
      init_trajectory(object,event,h)
      return
   end
   
   h.AvailableTraj = AvailableTraj;
   listbox.String =  String;

   %%
   listbox_type = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','popupmenu');


   listbox_type.Value = 1;
   type =  listbox_type.String{listbox_type.Value};

   listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Based','Event2msFcn:');
   result =  what(['Models-Signal-Simulation/BeaconSgn/',type]);
   listbox_Event2msFcn.String =result.m;
   
   %%
    listbox_type = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','popupmenu');


   listbox_type.Value = 1;
   type =  listbox_type.String{listbox_type.Value};

   listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Generation','Beacon Free','Event2msFcn:');
   result =  what(['Models-Signal-Simulation/FreeSgn/',type]);
   listbox_Event2msFcn.String =result.m;  
   %%
   update_signal_layer(h,'layer',true)
end

