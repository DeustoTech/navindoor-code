function btn_insert_planimetry(object,event,h)
%BTN_HAND_PLANIMETRY Summary of this function goes here
%   Detailed explanation goes here

    h.iur_figure.Pointer = 'arrow';
    h.zoom_iurfigure.Enable = 'off';
    h.pan_iurfigure.Enable = 'off' ;
    
   h.javacomponets.planimetry_layer.btn_insert.setSelected(1)
   h.javacomponets.trajectory_layer.btn_insert.setSelected(1)

end

