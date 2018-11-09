function CT02_panel_distribution(h,tab_trajectory)
%CT02_PANEL_DISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here
    panel_control    = uipanel(tab_trajectory,'Title','Control'  ,'Position',[0.04   0.82   0.96  0.18 ],'Tag','Control');
    CT02_panel_control(h,panel_control);

    panel_tools      = uipanel(tab_trajectory,'Title','Tool box' ,'Position',[0.0   0.0   0.04  1 ],'Tag','Tool box');
    CT02_panel_tools(h,panel_tools);
    
    panel_graphs     = uipanel(tab_trajectory,'Title','Graphs'   ,'Position',[0.04   0.0   0.80  0.82 ],'Tag','Graphs');
    CT02_panel_graphs(h,panel_graphs);
    
    panel_info_objects = uipanel(tab_trajectory,'Title','Info Objects','Position',[0.84   0.64   0.16  0.175 ],'Tag','Info Objects');
    CT02_panel_info_objects(h,panel_info_objects);

    panel_supertrajs = uipanel(tab_trajectory,'Title','Supertraj'    ,'Position',[0.84   0.0   0.16  0.64 ],'Tag','Supertraj');
    CT02_panel_supertrajs(h,panel_supertrajs);
    
end

