function btn_loadCallback(object,event,h)
%BTN_LOADCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    % selection of level 
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
    bd =  h.planimetry_layer(index_buildings);
    vb  = bd.level_layer(index_levels);
    
    [namepng,path] = uigetfile('data/png/*.png','Select the MATLAB code file');
    if ~isa(path,'double')
         file = {strcat(path,namepng)};
         vb.picture_level = graphs_picture_level;
         
         vb.picture_level.pngfile = file{1};
         % creamos la variables imagemap
         % a partir de la direccion cargada
         h.png_edit = true;
         vb.picture_level.picture = picture('pathpicture',file{:},'Parent',h.DirectAccess.Planimetry.Axes.Children,'XLim',bd.border.XLim,'YLim',bd.border.YLim);
         
    end
    
    waitfor(vb.picture_level.picture.imrect)
    
    h.png_edit = false;
    % refrescamos la figure
    update_planimetry_layer(h)
    
    
end

