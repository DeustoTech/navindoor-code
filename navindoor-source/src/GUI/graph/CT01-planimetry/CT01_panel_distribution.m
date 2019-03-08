function CT01_panel_distribution(h,tab_planimetry)
%PANEL_DISTRIBUTION_01 Generate all objects of distribution panel

    wt = 0.085;
    if isunix
        hgraphs = 0.88;
    elseif ismac 
        hgraphs = 0.85;
    elseif ispc
        hgraphs = 0.85;
    end
    panel_tools      = uipanel(tab_planimetry,'Title','','Position',[0.0   0.0   wt  1 ],'Tag','Tool box');
    CT01_panel_tools(h,panel_tools)

    panel_control    = uipanel(tab_planimetry,'Title',''  ,'Position',[wt   hgraphs   1-wt  1-hgraphs ],'Tag','Control');
    CT01_panel_control(h,panel_control)
     
    panel_graphs     = uipanel(tab_planimetry,'Title','Graphs'   ,'Position',[wt   0.0   1-wt hgraphs ],'Tag','Graphs');
    CT01_panel_graphs(h,panel_graphs)
    
    
end

