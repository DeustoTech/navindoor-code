function btn_viewCallback(object,event,h)
%BTN_VIEWCALLBAK Summary of this function goes here
%   Detailed explanation goes here

    h.planimetry_layer(1).building = generate_build(h.planimetry_layer);
    
    f = figure;
    ax = axes;
    plot(h.planimetry_layer(1).building,ax)
    view(45,40)
    grid on

end

