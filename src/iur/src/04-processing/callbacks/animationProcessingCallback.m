function animationProcessingCallback(object,event,h)
%ANIMATIONPROCESSINGCALLBACK Summary of this function goes here
%   Detailed explanation goes here

%% Indexs 
    % supertraj
    listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');
    index_straj = listbox_supertraj.Value;
    % estimators
    listbox_estimators = findobj_figure(h.iur_figure,'Signal Processing','Estimators','listbox');
    index_processing  = listbox_estimators.Value;

    if ~isempty(h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.estimation)
       strajs = [h.trajectory_layer(index_straj).supertraj h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.estimation];
       animation(strajs,h.planimetry_layer(1).build,'xx',3)   
    else
        errordlg('Can not do the animation, first pulse compute! button.')
    end


end

