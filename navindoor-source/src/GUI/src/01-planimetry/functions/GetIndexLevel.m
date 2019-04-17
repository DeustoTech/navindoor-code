function index_levels = GetIndexLevel(h)
%GETINDEXLEVEL Summary of this function goes here
%   Detailed explanation goes here
    %% Levels Panel 
    tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
    level_panel = findobj(tab_planimetry,'Title','Levels');
    boxlevels = findobj(level_panel,'Style','listbox');
    index_levels = boxlevels.Value;
end

