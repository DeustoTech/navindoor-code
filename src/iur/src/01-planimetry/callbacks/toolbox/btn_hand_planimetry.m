function btn_hand_planimetry(object,event,h)
%BTN_HAND_PLANIMETRY Summary of this function goes here
%   Detailed explanation goes here
    h.zoom_iurfigure.Direction = 'in';
    h.zoom_iurfigure.Enable = 'off';
    
    h.pan_iurfigure.Enable = 'on' ;

   h.javacomponets.planimetry_layer.btn_hand.setSelected(1)
   h.javacomponets.trajectory_layer.btn_hand.setSelected(1)
end

