function CT03_panel_distribution(h,tab_planimetry)
%CT02_PANEL_DISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here

    wt = 0.1;
    ws = 0.175;
    %% Trajectories    
    panel_supertrajs = uipanel(tab_planimetry,'Title','Trajectories'    ,'Position',[0   0.78   wt 0.22 ],'Tag','Supertraj');
    CT03_panel_supertrajs(h,panel_supertrajs);
    %%
    panel_signals = uipanel(tab_planimetry,'Title','Signals'    ,'Position',[wt   0.78   ws  0.22 ],'Tag','Signals');
    CT03_panel_signals(h,panel_signals);
     
    
    panel_control    = uipanel(tab_planimetry,'Title','Control'  ,'Position',[wt+ws   0.78   1-wt-ws   0.22 ],'Tag','Control');
    CT03_panel_control(h,panel_control);

    %panel_tools      = uipanel(tab_planimetry,'Title','Tool box' ,'Position',[0.0   0.0   0.04  1 ],'Tag','Tool box');
    %CT02_panel_tools(h,panel_tools);
    
    panel_graphs     = uipanel(tab_planimetry,'Title','Graphs'   ,'Position',[0.00   0.0   1.0  0.78 ],'Tag','Graphs');
    CT03_panel_graphs(h,panel_graphs);
    %%

    %panel_info_objects = uipanel(tab_planimetry,'Title','Info Objects','Position',[0.85   0.52   0.15  0.18 ],'Tag','Info Objects');
    %CT03_panel_info_objects(h,panel_info_objects);


end

