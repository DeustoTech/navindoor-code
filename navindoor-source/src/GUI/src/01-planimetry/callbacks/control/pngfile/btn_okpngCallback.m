function btn_okpngCallback(obj,event,h)
%BTN_OKPNGCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
    %% Building Panel 
    buildings_panel = findobj(tab_planimetry,'Title','Buildings');
    boxbuildings = findobj_figure(buildings_panel,'listbox');
    index_buildings = boxbuildings.Value;
    
    
    %% Levels Panel 
    level_panel = findobj(tab_planimetry,'Title','Levels');
    boxlevels = findobj(level_panel,'Style','listbox');
    index_levels = boxlevels.Value;

    bd =  h.planimetry_layer(index_buildings);
    vb  = bd.level_layer(index_levels);
    
    
    vb.picture_level.CData = vb.picture_level.picture.CData;

    delete(vb.picture_level.picture.imrect)

end

