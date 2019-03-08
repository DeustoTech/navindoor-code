function CT01_panel_control(h,panel_control)

    import javax.swing.*
    %% Panel Building 
    panel_buildings    = uipanel(panel_control,'Title','Buildings'   ,'Position',[0.0 0.00 0.15 1],'Tag','Buildings');
    CT01_pc_buildings(h,panel_buildings)
    %% Panel Levels 
    panel_levels    = uipanel(panel_control,'Title','Levels'   ,'Position',[0.15 0.00 0.13 1],'Tag','Levels');
    CT01_pc_levels(h,panel_levels)
    %% Panel Title: PNG File
    panel_png = uipanel(panel_control,'Title','PNG File' ,'Units','normalized','Position',[0.28 0.00 0.45 1.0],'Tag','PNG File');
    CT01_pc_png(h,panel_png)

    %% Panel Title: Dimension
    %panel_dimension = uipanel(panel_control,'Title','Dimension','Units','normalized','Position',[0.65 0.00 0.35 1.0],'Tag','Dimension');
    %CT01_pc_dimension(h,panel_dimension)

    %% Panel Title: Other Controls
    %%panel_others     = uipanel(panel_control,'Title','Other Options' ,'Position',[0.9 0.05 0.1 0.9],'Tag','Other Options');

end

