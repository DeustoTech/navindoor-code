function btnComputeCallback(object,event,h)
%BTNCOMPUTECALLBACK Summary of this function goes here
%   Detailed explanation goes here

%% Apagar
edit_generate = findobj_figure(h.iur_figure,'Signal Processing','Info Objects','Generate:');
edit_generate.String = 'FALSE';
edit_generate.BackgroundColor = [1 0 0];

%% Index Processing
list_box_estimators = findobj_figure(h.iur_figure,'Signal Processing','Estimators','listbox');
index_processing = list_box_estimators.Value;
%%

pause(0.5)

listbox_straj= findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');
index_straj = listbox_straj.Value;

%% Remover
h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.estimation = [];
h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.signals = [];

     jList = h.javacomponets.processing_layer.list_signals.object;
     
     signals = h.trajectory_layer(index_straj).aviable_signals((jList.getCheckedIndicies + 1)');
     if isempty(signals)
         errordlg('Please select least some one signal.')
         return
     end
     
     building = h.planimetry_layer(1).build;
     
     initstate_edit = findobj_figure(h.iur_figure,'Signal Processing','Control','Initial State','InitialState');
     try
        eval(['u0 = ',initstate_edit.String,';'])
     catch 
         initstate_edit.String = '[0 0 0 0 0]';
         errordlg(['Review, Initial State: ',initstate_edit.String]);
         return
     end
     
     h.trajectory_layer(index_straj).processing_layer(index_processing).supertraj = h.trajectory_layer(index_straj).supertraj;
     h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.building = building;
     h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.signals = signals;
     
     methods_pop = findobj_figure(h.iur_figure,'Signal Processing','Control','Default Methods','popupmenu');
     method = methods_pop.String(methods_pop.Value);
     
     %% Configuramos la clase Estimator, con los parametros de la pantalla
     switch method{:}
         case 'EKF'
            h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.bucle_function = @EKF_bucle;
            h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.initial_function = @EKF_init;

         case 'UKF'
            h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.bucle_function = @UKF_bucle;
            h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.initial_function = @UKF_init;
     end
     spacenoise = 0.5;
     velocitynoise = 0.5^2;
     ProcessNoise = [spacenoise spacenoise velocitynoise velocitynoise];
     parameters = {'ProcessNoise',ProcessNoise};
  
     h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.parameters = parameters;
  
     h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.initial_state = u0;
     h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.type_signal_available = {'RSS','ToF','Baro'};
                               
     %% Ejecutamos el metodo
     try
        h.trajectory_layer(index_straj).processing_layer(index_processing).estimator = compute(h.trajectory_layer(index_straj).processing_layer(index_processing).estimator);
     catch err
        errordlg(err.message) 
     end
     %% Calculamos el error
     strajs = [h.trajectory_layer(index_straj).supertraj h.trajectory_layer(index_straj).processing_layer(index_processing).estimator.estimation];
     h.trajectory_layer(index_straj).processing_layer(index_processing).error =  error(strajs);

     %% ecdf

     [A,B] = ecdf(h.trajectory_layer(index_straj).processing_layer(index_processing).error);
     h.trajectory_layer(index_straj).processing_layer(index_processing).ecdf.A  = A;
     h.trajectory_layer(index_straj).processing_layer(index_processing).ecdf.B  = B;
     
     update_processing_layer(h)



end

