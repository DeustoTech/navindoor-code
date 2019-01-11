function CT02_panel_graphs(h,panel_graphs)
%CT02_PANEL_GRAPHS Summary of this function goes here
%   Detailed explanation goes here
    

    %%
    ax_trajectory = axes('Parent',panel_graphs,'PlotBoxAspectRatio',[1 1 1],'PickableParts','all','Tag','axes');
    set(ax_trajectory,'defaultLinePickableParts','none', ...
                      'defaultTextPickableParts','none', ...
                      'defaultImagePickableParts','none');
    ax_trajectory.ButtonDownFcn = {@axes_trajectory_callback,h};


    ax_trajectory.XLim = [ 0 50 ];
    ax_trajectory.YLim = [ 0 50 ]; 
    
    ax_trajectory.XLabel.String = 'x[m]';
    ax_trajectory.YLabel.String = 'y[m]';

    %%
        panel_levels    = uipanel(panel_graphs,'Title','Levels'   ,'Position',[0.01 0.85 0.075 0.15],'Tag','Levels');

        uicontrol('style','listbox', 'Parent',panel_levels,    ...
                  'String','0',                                ...
                  'Units','normalized',                        ... 
                  'Position',[0.1 0.1 0.7 0.8],                ...
                  'Callback',{@listbox_trajectoryCallback,h},  ...
                  'Tag','listbox');
end

