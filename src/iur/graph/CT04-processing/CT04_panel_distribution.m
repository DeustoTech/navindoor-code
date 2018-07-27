function CT03_panel_distribution(h,tab_processing)
%CT02_PANEL_DISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here
    panel_control    = uipanel(tab_processing,'Title','Control'  ,'Position',[0.00   0.78   0.7  0.22 ],'Tag','Control');
    CT04_panel_control(h,panel_control);

    panel_supertrajs = uipanel(tab_processing,'Title','Supertraj'    ,'Position',[0.70   0.78   0.15  0.22 ],'Tag','Supertraj');
    CT04_panel_supertrajs(h,panel_supertrajs);
        
    panel_signal_aviable = uipanel(tab_processing,'Title','Signals Available'   ,'Position',[0.85   0.78   0.15  0.22 ],'Tag','Signals Available');
    CT04_panel_signal_aviable(h,panel_signal_aviable);
    %panel_tools      = uipanel(tab_planimetry,'Title','Tool box' ,'Position',[0.0   0.0   0.04  1 ],'Tag','Tool box');
    %CT02_panel_tools(h,panel_tools);
    
    panel_graphs     = uipanel(tab_processing,'Title','Graphs'   ,'Position',[0.00   0.0   0.85  0.78 ],'Tag','Graphs');
    CT04_panel_graphs(h,panel_graphs);


    panel_info_objects = uipanel(tab_processing,'Title','Info Objects','Position',[0.85   0.6   0.15  0.18 ],'Tag','Info Objects');
    CT04_panel_info_objects(h,panel_info_objects);

    panel_straj_estimation = uipanel(tab_processing,'Title','Estimators','Position',[0.85   0.0   0.15  0.6 ],'Tag','Estimators');
    CT04_panel_straj_estimation(h,panel_straj_estimation);
    
end

