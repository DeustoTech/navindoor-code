function init_signal_generation(object,event,h)
%   Detailed explanation goes here

   h.planimetry_layer(1).building = generate_build(h.planimetry_layer);

   listbox_strajs = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
   supetraj_panel = findobj_figure(h.iur_figure,'Signal Generation','Supertraj');
   
   listbox = findobj(supetraj_panel,'Style','listbox');
   listbox.String =  {h.trajectory_layer.label};

   update_signal_layer(h,'layer',true)
end

