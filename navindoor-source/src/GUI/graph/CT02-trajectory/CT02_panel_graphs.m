function CT02_panel_graphs(h,panel_graphs)
% Creamos todos los elementos de la GUI asociados al panel Graphs, del tab
% Trajectory

    %% Creamos el axes de la trajectoria 
    ax_trajectory = axes('Parent',panel_graphs,'PlotBoxAspectRatio',[1 1 1],'PickableParts','all','Tag','axes');
    set(ax_trajectory,'defaultLinePickableParts','none', ...
                      'defaultTextPickableParts','none', ...
                      'defaultImagePickableParts','none');
    ax_trajectory.ButtonDownFcn = {@axes_trajectory_callback,h};

    ax_trajectory.XLabel.String = 'x[m]';
    ax_trajectory.YLabel.String = 'y[m]';
              
      [XLim YLim] = xylimits(h.planimetry_layer.osm.limits);
    ax_trajectory.XLim = XLim;
    ax_trajectory.YLim = YLim; 

     line(h.planimetry_layer.osm.OsmBuilding,'Parent',ax_trajectory,'Color','c');
     line(h.planimetry_layer.osm.OsmWays,'Parent',ax_trajectory,'Color','y');
end

