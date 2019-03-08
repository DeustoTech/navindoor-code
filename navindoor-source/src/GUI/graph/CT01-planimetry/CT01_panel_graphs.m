function CT01_panel_graphs(h,panel_graphs)
%CT01_PANEL_GRAPHS Summary of this function goes here
%   Detailed explanation goes here
ax_planimetry = axes('Parent',panel_graphs,'PlotBoxAspectRatio',[1 1 1],'PickableParts','all','Tag','axes');

set(ax_planimetry,'defaultLinePickableParts' ,'none', ...
                  'defaultTextPickableParts' ,'none', ...
                  'defaultImagePickableParts','none');
set(ax_planimetry,'ButtonDown',{@axes_planimetry_callback,h})

[XLim YLim] = xylimits(h.osm.limits);
ax_planimetry.XLim = XLim;
ax_planimetry.YLim = YLim; 

ax_planimetry.XLabel.String = 'x[m]';
ax_planimetry.YLabel.String = 'y[m]';

h.graph_layout_osm_buildings = line(h.osm.OsmBuilding,'Parent',ax_planimetry,'Color','c');
h.graph_layout_osm_ways = line(h.osm.OsmWays,'Parent',ax_planimetry,'Color','y');
end

