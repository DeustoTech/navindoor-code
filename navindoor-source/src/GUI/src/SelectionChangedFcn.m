function SelectionChangedFcn(object,event,h)
%SELECTIONCHANGEDFCN Summary of this function goes here
%   Detailed explanation goes here
    switch  event.NewValue.Title
        case 'Planimetry'
            init_planimetry(object,event,h)
        case 'Trajectory'
            init_trajectory(object,event,h)
        case 'Signal Generation'
            init_signal_generation(object,event,h)
        case 'Signal Processing'
            init_signal_processing(object,event,h)
        case 'Methods Comparison'
            init_methods_comparison(object,event,h)
    end
    
    h.iur_figure.Pointer = 'arrow';
    h.zoom_iurfigure.Enable = 'off';
    h.pan_iurfigure.Enable = 'off' ;
end

