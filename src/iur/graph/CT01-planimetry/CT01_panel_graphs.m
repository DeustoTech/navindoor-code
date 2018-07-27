function CT01_panel_graphs(h,panel_graphs)
%CT01_PANEL_GRAPHS Summary of this function goes here
%   Detailed explanation goes here
ax_planimetry = axes('Parent',panel_graphs,'PlotBoxAspectRatio',[1 1 1],'PickableParts','all','Tag','axes');
set(ax_planimetry,'defaultLinePickableParts','none','defaultTextPickableParts','none');
set(ax_planimetry,'ButtonDown',{@axes_planimetry_callback,h})
dimensions = h.planimetry_layer.build.levels.dimensions;

ax_planimetry.XLim = [ 0 dimensions(1) ];
ax_planimetry.YLim = [ 0 dimensions(2) ]; 

ax_planimetry.XLabel.String = 'x[m]';
ax_planimetry.YLabel.String = 'y[m]';


end

