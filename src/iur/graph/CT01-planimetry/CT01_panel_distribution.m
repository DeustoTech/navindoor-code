function CT01_panel_distribution(h,tab_planimetry)
%PANEL_DISTRIBUTION_01 Summary of this function goes here
%   Detailed explanation goes here
    
    panel_control    = uipanel(tab_planimetry,'Title','Control'  ,'Position',[0.04   0.82   0.96  0.18 ],'Tag','Control');
    CT01_panel_control(h,panel_control)

    panel_tools      = uipanel(tab_planimetry,'Title','Tool box' ,'Position',[0.0   0.0   0.04  1 ],'Tag','Tool box');
    CT01_panel_tools(h,panel_tools)
        
    panel_graphs     = uipanel(tab_planimetry,'Title','Graphs'   ,'Position',[0.04   0.0   0.96  0.82 ],'Tag','Graphs');
    CT01_panel_graphs(h,panel_graphs)
    
    
end

