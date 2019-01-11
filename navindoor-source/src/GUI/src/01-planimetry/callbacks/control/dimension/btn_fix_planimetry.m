function btn_fix_planimetry(object,event,h)
%BTN_FIX_PLANIMETRY Summary of this function goes here
%   Detailed explanation goes here
h.planimetry_layer.XLim;

xl = findobj_figure(h.iur_figure,'Planimetry','Dimension','xlim');
yl = findobj_figure(h.iur_figure,'Planimetry','Dimension','ylim');

listbox = findobj_figure(h.iur_figure,'Planimetry','Control','Levels','listbox');
index = listbox.Value;

h.planimetry_layer(index).XLim(2) = str2num(xl.String);
h.planimetry_layer(index).YLim(2) = str2num(yl.String);


h.planimetry_layer(index).XLim_image(2) = str2num(xl.String);
h.planimetry_layer(index).YLim_image(2) = str2num(yl.String);

generate_build(h.planimetry_layer);

update_planimetry_layer(h,'auto_zoom',true,'replot',true);

end

