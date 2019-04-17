function rout = SelectHeightClick(h,r,rbefore)
%SELECTHEIGHTCLICK Summary of this function goes here
%   Detailed explanation goes here

    lenbuildings = length(h.planimetry_layer.map.buildings);
    logical_building = arrayfun(@(index) isinterior(h.planimetry_layer.map.buildings(index).border.polyshape,r),1:lenbuildings);
    if logical_building
        
    end
end

