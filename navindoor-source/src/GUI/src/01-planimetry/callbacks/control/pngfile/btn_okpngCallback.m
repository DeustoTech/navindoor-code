function btn_okpngCallback(~,~,h)

    %% Building Panel 
    index_buildings = GetIndexBuilding(h);
    index_levels    = GetIndexLevel(h);
    
    bd =  h.planimetry_layer.building_layers(index_buildings);
    vb  = bd.level_layer(index_levels);
    
    vb.picture_level.CData = vb.picture_level.picture.CData;

    delete(vb.picture_level.picture.imrect)

    PNGbtnstate(h,'hold')
end

