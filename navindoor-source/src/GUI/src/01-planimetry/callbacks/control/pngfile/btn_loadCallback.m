function btn_loadCallback(object,event,h)
%BTN_LOADCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    % selection of level 

    index_levels    = GetIndexLevel(h);
    index_buildings = GetIndexBuilding(h);
    %%
    bd =  h.planimetry_layer.building_layers(index_buildings);
    vb  = bd.level_layer(index_levels);
    
    file_data = fullfile(h.navindoor_path,'data','png','*.png');
    [namepng,path] = uigetfile(file_data,'Select the MATLAB code file');
    if ~isa(path,'double')
        file = {strcat(path,namepng)};
        vb.picture_level = graphs_picture_level;
         
        vb.picture_level.pngfile = file{1};
        % creamos la variables imagemap
        % a partir de la direccion cargada
        h.png_edit = true;
         
        if ~isempty(vb.picture_level.picture)
            delete(vb.picture_level.picture.Image);
        end
        vb.picture_level.picture = picture('pathpicture',file{:},'Parent',h.DirectAccess.Planimetry.Axes.Children,'XLim',bd.border.XLim,'YLim',bd.border.YLim);

        EditPicture(h,vb)

        plot(vb.picture_level.picture,'Parent',h.DirectAccess.Planimetry.Axes.Children)
        update_planimetry_layer(h)
    end

    
    
    
    
end

