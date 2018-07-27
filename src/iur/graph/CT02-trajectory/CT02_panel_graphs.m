function CT02_panel_graphs(h,panel_graphs)
%CT02_PANEL_GRAPHS Summary of this function goes here
%   Detailed explanation goes here
    ax_trajectory = axes('Parent',panel_graphs,'PlotBoxAspectRatio',[1 1 1],'PickableParts','all','Tag','axes');
    set(ax_trajectory,'defaultLinePickableParts','none','defaultTextPickableParts','none');
    ax_trajectory.ButtonDownFcn = {@axes_trajectory_callback,h};

    dimensions = h.planimetry_layer(1).build.levels.dimensions;

    ax_trajectory.XLim = [ 0 dimensions(1) ];
    ax_trajectory.YLim = [ 0 dimensions(2) ]; 
    
    ax_trajectory.XLabel.String = 'x[m]';
    ax_trajectory.YLabel.String = 'y[m]';

    
end

