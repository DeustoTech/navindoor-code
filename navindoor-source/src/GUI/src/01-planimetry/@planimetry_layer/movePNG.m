function  movePNG(iPlanimetryLayer,r)
%MOVEPNG Summary of this function goes here
%   Detailed explanation goes here
iPlanimetryLayer.XLim_image = iPlanimetryLayer.XLim_image + [r(1) r(1)];
iPlanimetryLayer.YLim_image = iPlanimetryLayer.YLim_image + [r(2) r(2)];
end

