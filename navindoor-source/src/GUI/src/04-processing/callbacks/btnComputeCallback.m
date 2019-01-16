function btnComputeCallback(object,event,h)
%BTNCOMPUTECALLBACK Summary of this function goes here
%   Detailed explanation goes here

    %% Apagar
    %edit_generate = findobj_figure(h.iur_figure,'Signal Processing','Info Objects','Generate:');
    %edit_generate.String = 'Waiting ...';
    %edit_generate.BackgroundColor = [1 1 0];

    %% Index Processing
    list_box_estimators = findobj_figure(h.iur_figure,'Signal Processing','Estimators','listbox');
    index_processing = list_box_estimators.Value;
    %%
    %%
    pause(0.5)

    listbox_straj= findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');
    index_straj = listbox_straj.Value;

    %%
    h.AvailableTraj(index_straj).processing_layer(index_processing).mt = [];
    %%
    jList = h.javacomponets.processing_layer.list_signals.object;
    %%
    % Seleccionamos las señales selecionadas en el listbox 'Avaiable Signals'
    signals = h.AvailableTraj(index_straj).aviable_signals((jList.getCheckedIndicies + 1)');
    signals = {signals.signal};
     
     
     if isempty(signals)
         errordlg('Please select least some one signal.','Error','modal')
         update_processing_layer(h)
         return
     end
     
     
     
     %%
     ibuilding = h.planimetry_layer(1).building;
     %% Ejecutamos el metodo
     set(h.iur_figure, 'pointer', 'watch')
     pause(0.05)
     
     h.AvailableTraj(index_straj).processing_layer(index_processing).mt = [];
     h.AvailableTraj(index_straj).processing_layer(index_processing).RefGT_estimate = []; 
     h.AvailableTraj(index_straj).processing_layer(index_processing).error  = [];
     
     try
        
        listbox_Event2msFcn = findobj_figure(h.iur_figure,'Signal Processing','Control','listbox');
        AlgorithmFcn = str2func(listbox_Event2msFcn.String{listbox_Event2msFcn.Value}(1:(end-2)));
        mtTrajectory = AlgorithmFcn(signals,ibuilding,h.AvailableTraj(index_straj).traj);
        %%
        h.AvailableTraj(index_straj).processing_layer(index_processing).mt = mtTrajectory;
        h.AvailableTraj(index_straj).processing_layer(index_processing).RefGT_estimate = mat2RefGT(mtTrajectory); 
       
        RefGT_estimate = h.AvailableTraj(index_straj).processing_layer(index_processing).RefGT_estimate;
        RefGT_real = h.AvailableTraj(index_straj).traj.GroundTruths.Ref;
        %
        h.AvailableTraj(index_straj).processing_layer(index_processing).error = error(RefGT_estimate,RefGT_real);
        
        [A,B] = ecdf(h.AvailableTraj(index_straj).processing_layer(index_processing).error(:,2));
        h.AvailableTraj(index_straj).processing_layer(index_processing).ecdf.A  = A;
        h.AvailableTraj(index_straj).processing_layer(index_processing).ecdf.B  = B;
     
        h.AvailableTraj(index_straj).processing_layer(index_processing).AlgorithmFcn = AlgorithmFcn;
        h.AvailableTraj(index_straj).processing_layer(index_processing).Signals = signals;
        
        %% Calculamos el error
        %mtRef = h.AvailableTraj(index_straj).traj.mt;
        %h.AvailableTraj(index_straj).processing_layer(index_processing).error = sqrt((mtRef(:,1) - mtTrajectory(:,1)).^2  + ...
        %                                                                            (mtRef(:,2) - mtTrajectory(:,2)).^2  + ...
        %                                                                            (mtRef(:,3) - mtTrajectory(:,3)).^2)';
      
        set(h.iur_figure, 'pointer', 'arrow')
         msgbox('The successful trajectory estimation has been created.','notification','modal')

     catch err
        set(h.iur_figure, 'pointer', 'arrow')
        errordlg(err.getReport,'Error','modal') 
     end

     %% ecdf

     update_processing_layer(h,'layer',true)



end

