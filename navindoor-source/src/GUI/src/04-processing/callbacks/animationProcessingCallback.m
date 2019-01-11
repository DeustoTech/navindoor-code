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

    if ~isempty(h.AvailableTraj(index_straj).processing_layer(index_processing).mt)
       GT_estimate = h.AvailableTraj(index_straj).processing_layer(index_processing).RefGT_estimate;
       GT_real     = h.trajectory_layer(index_straj).traj.GroundTruths.Ref;
       GT_estimate.label = 'estimate';
       GT_real.label = 'real';
       
       animation([GT_estimate ,GT_real],'building',h.planimetry_layer(1).building,'xx',5)   
    else
        errordlg('Can not do the animation, first pulse compute! button.')
    end


end

