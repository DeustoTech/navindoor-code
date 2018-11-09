function btn_viewCallback(object,event,h)
%BTN_VIEWCALLBAK Summary of this function goes here
%   Detailed explanation goes here

    generate_build(h.planimetry_layer)
    
    figure
    plot(h.planimetry_layer(1).build)
    view(45,40)
    grid on

end

