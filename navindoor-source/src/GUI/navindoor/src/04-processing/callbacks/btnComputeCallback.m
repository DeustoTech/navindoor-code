function btnComputeCallback(object,event,h)
%BTNCOMPUTECALLBACK Summary of this function goes here
%   Detailed explanation goes here

    %% Apagar
    edit_generate = findobj_figure(h.iur_figure,'Signal Processing','Info Objects','Generate:');
    edit_generate.String = 'Waiting ...';
    edit_generate.BackgroundColor = [1 1 0];

    %% Index Processing
    list_box_estimators = findobj_figure(h.iur_figure,'Signal Processing','Estimators','listbox');
    index_processing = list_box_estimators.Value;
    %%
    %%
    pause(0.5)

    listbox_straj= findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');
    index_straj = listbox_straj.Value;

    %%
    h.trajectory_layer(index_straj).processing_layer(index_processing).mt = [];
    %%
     jList = h.javacomponets.processing_layer.list_signals.object;
     
     signals = h.trajectory_layer(index_straj).aviable_signals((jList.getCheckedIndicies + 1)');
     
     
     
     if isempty(signals)
         errordlg('Please select least some one signal.','Error','modal')
         update_processing_layer(h)
         return
     end
     
     
     
     %%
     ibuilding = h.planimetry_layer(1).building;
     %% Ejecutamos el metodo
     set(h.iur_figure, 'pointer', 'watch')
     pause(0.1)
     try
        listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Processing','Control','listbox');
        AlgorithmFcn = str2func(listbox_Event2msFcn.String{listbox_Event2msFcn.Value}(1:(end-2)));
        mtTrajectory = AlgorithmFcn(signals,ibuilding,h.trajectory_layer(index_straj).traj);
        %%
        h.trajectory_layer(index_straj).processing_layer(index_processing).mt = mtTrajectory;
        
        %
        h.trajectory_layer(index_straj).processing_layer(index_processing).AlgorithmFcn = AlgorithmFcn;
        h.trajectory_layer(index_straj).processing_layer(index_processing).Signals = signals;
        
        %% Calculamos el error
        %mtRef = h.trajectory_layer(index_straj).traj.mt;
        %h.trajectory_layer(index_straj).processing_layer(index_processing).error = sqrt((mtRef(:,1) - mtTrajectory(:,1)).^2  + ...
        %                                                                            (mtRef(:,2) - mtTrajectory(:,2)).^2  + ...
        %                                                                            (mtRef(:,3) - mtTrajectory(:,3)).^2)';
      
        set(h.iur_figure, 'pointer', 'arrow')

     catch err
        set(h.iur_figure, 'pointer', 'arrow')
        errordlg(err.message,'Error','modal') 
     end

     %% ecdf

     update_processing_layer(h,'layer',true)



end

