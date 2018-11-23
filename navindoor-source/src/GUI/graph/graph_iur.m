function graph_iur(h)
    %graph_iur - function principal para la generacion de la figura MATLAB que contendrá 
    % toda l aaplicación iurgui
    %% Menu
    file_menu = uimenu(h.iur_figure,'Text','File','Tag','file_menu');
        open_menu = uimenu(file_menu,'Text','Open','Tag','open_menu');
            open_build = uimenu(open_menu,'Text','Open building' ,'Tag','open_build','Callback',{@open_building_Callback,h});
            %open_traj  = uimenu(open_menu,'Text','Open trajectory','Tag','open_traj','Callback',{@open_trajectory_Callback,h});

        save_menu = uimenu(file_menu,'Text','Save','Tag','save_menu');
            save_level = uimenu(save_menu,'Text','level','Tag','save_level','Callback',{@save_levelCallback,h});
            save_build = uimenu(save_menu,'Text','building','Tag','save_build','Callback',{@save_buildCallback,h});
            
            save_straj  = uimenu(save_menu,'Text','trajectory','Tag','save_straj','Callback',{@save_strajCallback,h});
            save_signal = uimenu(save_menu,'Text','signal','Tag','save_signal','Callback',{@save_signalCallback,h});
        close_menu = uimenu(file_menu,'Text','Close','Tag','close_menu','Callback',{@close_Callback,h},'accelerator','W');
    %% Tabs 
    tabgp = uitabgroup(h.iur_figure,                       ...
                       'Units','normalize',                ...
                       'Position',[0.005 0.01 0.99 0.98],   ...
                       'Tag','tabgroup',                   ...
                       'SelectionChangedFcn',{@SelectionChangedFcn,h});
    FontPanel  = 'Comic Sans MS';
    %% Deafult Propierties of Children Tree
    set(h.iur_figure,'defaultuipanelFontName',FontPanel)
    set(h.iur_figure,'defaultuicontrolFontName',FontPanel)
    
    if ismac
        set(h.iur_figure,'defaultuicontrolFontSize',11)
        set(h.iur_figure,'defaultuipanelFontSize',12)
    end
    if ispc
        set(h.iur_figure,'defaultuicontrolFontSize',9)
    end
    %% Planimetry
    tab_planimetry   = uitab(tabgp,'Title','Planimetry','Tag','Planimetry');
    % Will Generate  graphics objects
    CT01_panel_distribution(h,tab_planimetry);
   
    %% Trajectory
    tab_trajectory   = uitab(tabgp,'Title','Trajectory','Tag','Trajectory');
    % Will Generate  graphics objects
    CT02_panel_distribution(h,tab_trajectory);

    %% Signals 
    % Will Generate  graphics objects
    tab_signals      = uitab(tabgp,'Title','Signal Generation','Tag','Signal Generation');
    CT03_panel_distribution(h,tab_signals);
    %% Processing
    tab_processing   = uitab(tabgp,'Title','Signal Processing','Tag','Signal Processing');
    CT04_panel_distribution(h,tab_processing);
    %% Comparison
    tab_comparison   = uitab(tabgp,'Title','Methods Comparison','Tag','Methods Comparison');
    CT05_panel_distribution(h,tab_comparison);
end

