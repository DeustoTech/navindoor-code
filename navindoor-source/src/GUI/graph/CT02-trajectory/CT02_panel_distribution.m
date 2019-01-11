function CT02_panel_distribution(h,tab_trajectory)
%CT02_PANEL_DISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here
    wt = 0.15;
    wm = 0.15;
    hg = 0.82;
    %% Control
    

    %% Trajectories
    panel_supertrajs = uipanel(tab_trajectory,'Title','Trajectories'    ,'Position',[0   0.7   wt 0.3 ],'Tag','Supertraj');
    CT02_panel_supertrajs(h,panel_supertrajs);
    

    %% Tool box 
    panel_tools      = uipanel(tab_trajectory,'Title','Tool box' ,'Position',[0.0   0.0   wt  0.7 ],'Tag','Tool box');
    CT02_panel_tools(h,panel_tools);
    
    
    %% Graphs
    panel_graphs     = uipanel(tab_trajectory,'Title','Graphs'   ,'Position',[wt   0.0   1-wt-wm  1.0 ],'Tag','Graphs');
    CT02_panel_graphs(h,panel_graphs);
    
    %panel_info_objects = uipanel(tab_trajectory,'Title','Info Objects','Position',[0.84   0.64   0.16  0.175 ],'Tag','Info Objects');
    %CT02_panel_info_objects(h,panel_info_objects);
    
    %% Models
    panel_control    = uipanel(tab_trajectory,'Title','Models'  ,'Position',[1-wm   0.0   wm  1.0 ],'Tag','Control');
    CT02_panel_control(h,panel_control);


    
end

