function CT05_panel_distribution(h,tab_processing)
%CT02_PANEL_DISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here
    %panel_control    = uipanel(tab_processing,'Title','Control'  ,'Position',[0.00   0.78   0.7  0.22 ],'Tag','Control');
    %CT04_panel_control(h,panel_control);

    panel_compare  = uipanel(tab_processing,'Title','Compare'    ,'Position',[0.85   0.8   0.15  0.2 ],'Tag','Compares');
    CT05_panel_compare(h,panel_compare);
    
    panel_supertrajs = uipanel(tab_processing,'Title','Trajectory'    ,'Position',[0.85   0.4   0.15  0.4 ],'Tag','Supertraj');
    CT05_panel_supertrajs(h,panel_supertrajs);
        
    panel_signal_aviable = uipanel(tab_processing,'Title','Estimators Available'   ,'Position',[0.85   0.0   0.15  0.4 ],'Tag','Estimators Available');
    %CT04_panel_signal_aviable(h,panel_signal_aviable);
    %panel_tools      = uipanel(tab_planimetry,'Title','Tool box' ,'Position',[0.0   0.0   0.04  1 ],'Tag','Tool box');
    %CT02_panel_tools(h,panel_tools);
    
    panel_graphs     = uipanel(tab_processing,'Title','Graphs'   ,'Position',[0.00   0.0   0.85  1 ],'Tag','Graphs');
    CT05_panel_graphs(h,panel_graphs);


    
end

