function btn_scale_planimetry(object,event,h)
%BTN_SCALE_PLANIMETRY Summary of this function goes here
%   Detailed explanation goes here

xs = findobj_figure(h.iur_figure,'Planimetry','Dimension','xlimscale');
ys = findobj_figure(h.iur_figure,'Planimetry','Dimension','ylimscale');

listbox = findobj_figure(h.iur_figure,'Planimetry','Control','Levels','listbox');
index = listbox.Value;

h.planimetry_layer(index).XLim(2) = str2num(xs.String)*h.planimetry_layer(index).XLim(2);
h.planimetry_layer(index).YLim(2) = str2num(ys.String)*h.planimetry_layer(index).YLim(2);

h.planimetry_layer(index).XLim_image(2) = str2num(xs.String)*h.planimetry_layer(index).XLim_image(2);
h.planimetry_layer(index).YLim_image(2) = str2num(ys.String)*h.planimetry_layer(index).YLim_image(2);



xs.String = '1';
ys.String = '1';

generate_build(h.planimetry_layer);
update_planimetry_layer(h,'auto_zoom',false,'replot',true);

end

