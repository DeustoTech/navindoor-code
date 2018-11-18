function CT04_panel_distribution(h,tab_processing)
%CT02_PANEL_DISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here
    %% Control
    panel_control           = uipanel(tab_processing,'Title','Control'  ,'Position',[0.00   0.78   0.575  0.22 ],'Tag','Control');
    CT04_panel_control(h,panel_control);
    %% Supertraj
    panel_supertrajs        = uipanel(tab_processing,'Title','trajectories' ,'Position',[0.575   0.78   0.20  0.22 ],'Tag','Supertraj');
    CT04_panel_supertrajs(h,panel_supertrajs);
    %% Signals Available
    panel_signal_aviable    = uipanel(tab_processing,'Title','Signals Available'   ,'Position',[0.775   0.78   0.225  0.22 ],'Tag','Signals Available');
    CT04_panel_signal_aviable(h,panel_signal_aviable);
    %% Graphs
    panel_graphs            = uipanel(tab_processing,'Title','Graphs'   ,'Position',[0.00   0.0   0.85  0.78 ],'Tag','Graphs');
    CT04_panel_graphs(h,panel_graphs);
    %% Info Objects
    panel_info_objects      = uipanel(tab_processing,'Title','Info Objects','Position',[0.85   0.6   0.15  0.18 ],'Tag','Info Objects');
    CT04_panel_info_objects(h,panel_info_objects);
    %% Estimators 
    panel_straj_estimation  = uipanel(tab_processing,'Title','Estimators','Position',[0.85   0.0   0.15  0.6 ],'Tag','Estimators');
    CT04_panel_straj_estimation(h,panel_straj_estimation);
    
end

