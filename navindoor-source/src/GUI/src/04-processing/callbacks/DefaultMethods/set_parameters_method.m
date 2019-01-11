function set_parameters_method(object,event,h)
%SET_PARAMETERS_METHOD Summary of this function goes here
%   Detailed explanation goes here
    popupmenu = findobj_figure(h.iur_figure,'Signal Processing','Control','Default Methods','popupmenu');
    
    listbox_straj= findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');
    index_straj = listbox_straj.Value;

    list_box_estimators = findobj_figure(h.iur_figure,'Signal Processing','Estimators','listbox');
    index_processing = list_box_estimators.Value;
    
    
    method = popupmenu.String{popupmenu.Value};
    
    switch method
        case 'EKF'
            h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.parameters = EKF_parameters_gui;
    end
    
end

