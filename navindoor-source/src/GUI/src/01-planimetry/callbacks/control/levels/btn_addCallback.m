function btn_addCallback(object,event,h)
%BTN_ADDCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    h.planimetry_layer(end+1) = planimetry_layer;
    h.planimetry_layer(end).height = h.planimetry_layer(end-1).height + 5;
    update_planimetry_layer(h)
    
    
end

