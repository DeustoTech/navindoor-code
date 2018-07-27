function CT05_panel_graphs(h,panel_graphs)
%CT05_PANEL_GRAPHS Summary of this function goes here
%   Detailed explanation goes here

    %% Tabs 
    tabgp = uitabgroup(panel_graphs,                       ...
                       'Units','normalize',                 ...
                       'Position',[0.00 0.00 1 1],       ...
                       'Tag','Tab');          


   color = [ 0 0 0.75];

    % Deafult Methods 
   tab_error  = uitab(tabgp,'Title','Error in Time','Tag','Error in Time');
   tab_error.ForegroundColor = color;

   tab_ecdf   = uitab(tabgp,'Title','Cumulative Distribution','Tag','Cumulative Distribution');
   tab_ecdf.ForegroundColor = color;

end

