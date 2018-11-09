function btn_minusCallback(object,event,h)
%BTN_ADDCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    if length(h.planimetry_layer) > 1
        h.planimetry_layer(end) = [];
        update_planimetry_layer(h)
    end
end

