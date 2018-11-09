function CT01_panel_distribution(h,tab_planimetry)
%PANEL_DISTRIBUTION_01 Generate all objects of distribution panel 
    panel_control    = uipanel(tab_planimetry,'Title','Control'  ,'Position',[0.1   0.82   0.9  0.18 ],'Tag','Control');
    CT01_panel_control(h,panel_control)

    panel_tools      = uipanel(tab_planimetry,'Title','','Position',[0.0   0.0   0.1  1 ],'Tag','Tool box');
    CT01_panel_tools(h,panel_tools)
        
    panel_graphs     = uipanel(tab_planimetry,'Title','Graphs'   ,'Position',[0.1   0.0   0.9 0.82 ],'Tag','Graphs');
    CT01_panel_graphs(h,panel_graphs)
    
    
end

