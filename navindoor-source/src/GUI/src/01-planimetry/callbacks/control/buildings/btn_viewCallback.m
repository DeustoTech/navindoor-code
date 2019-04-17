function btn_viewCallback(object,event,h)
%BTN_VIEWCALLBAK Summary of this function goes here
%   Detailed explanation goes here

     GenerateMap(h.planimetry_layer);
    buildings = h.planimetry_layer.map.buildings;
    f = figure;
    ax = axes;
    plot(buildings,ax)
    view(45,40)
    grid on

end

