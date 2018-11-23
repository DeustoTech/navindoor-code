function btn_zoomminus_planimetry(object,event,h)
%BTN_HAND_PLANIMETRY Summary of this function goes here
%   Detailed explanation goes here
    h.zoom_iurfigure.Direction = 'out';
    h.zoom_iurfigure.Enable = 'on';
    h.pan_iurfigure.Enable = 'off' ;

   h.javacomponets.planimetry_layer.btn_zoomminus.setSelected(1)
   h.javacomponets.trajectory_layer.btn_zoomminus.setSelected(1)
end

