function index_buildings = GetIndexBuilding(h)
%INDEXBUILDING Summary of this function goes here
%   Detailed explanation goes here
    %% Building Panel 
    tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
    buildings_panel = findobj(tab_planimetry,'Title','Buildings');
    boxbuildings = findobj_figure(buildings_panel,'listbox');
    index_buildings = boxbuildings.Value;
    
end

