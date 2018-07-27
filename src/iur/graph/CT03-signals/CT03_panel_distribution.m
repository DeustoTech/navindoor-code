function CT03_panel_distribution(h,tab_planimetry)
%CT02_PANEL_DISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here
    panel_control    = uipanel(tab_planimetry,'Title','Control'  ,'Position',[0.00   0.78   0.85  0.22 ],'Tag','Control');
    CT03_panel_control(h,panel_control);

    %panel_tools      = uipanel(tab_planimetry,'Title','Tool box' ,'Position',[0.0   0.0   0.04  1 ],'Tag','Tool box');
    %CT02_panel_tools(h,panel_tools);
    
    panel_graphs     = uipanel(tab_planimetry,'Title','Graphs'   ,'Position',[0.00   0.0   0.85  0.78 ],'Tag','Graphs');
    CT03_panel_graphs(h,panel_graphs);
    
    panel_supertrajs = uipanel(tab_planimetry,'Title','Supertraj'    ,'Position',[0.85   0.7   0.15  0.3 ],'Tag','Supertraj');
    CT03_panel_supertrajs(h,panel_supertrajs);
    
    
    panel_info_objects = uipanel(tab_planimetry,'Title','Info Objects','Position',[0.85   0.52   0.15  0.18 ],'Tag','Info Objects');
    CT03_panel_info_objects(h,panel_info_objects);

    panel_signals = uipanel(tab_planimetry,'Title','Signals'    ,'Position',[0.85   0.0   0.15  0.52 ],'Tag','Signals');
    CT03_panel_signals(h,panel_signals);
    
end

