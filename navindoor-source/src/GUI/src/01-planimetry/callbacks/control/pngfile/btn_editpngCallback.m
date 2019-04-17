function btn_editpngCallback(object,event,h)
%BTN_EDITPNGCALLBACK Summary of this function goes here
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
    %%
    bd =  h.planimetry_layer.building_layers(index_buildings);
    vb  = bd.level_layer(index_levels);
    %%
    file = {vb.picture_level.pngfile};
    vb.picture_level.picture = picture('pathpicture',file{:},'Parent',h.DirectAccess.Planimetry.Axes.Children,'XLim',bd.border.XLim,'YLim',bd.border.YLim);
    %%
    EditPicture(h,vb)

    plot(vb.picture_level.picture,'Parent',h.DirectAccess.Planimetry.Axes.Children)
    update_planimetry_layer(h)
end

