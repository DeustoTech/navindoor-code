function result = EKF_bucle(estimator,initial_fun_workspace,measurements,varargin)
%EKF_INIT Summary of this function goes here
%   Detailed explanation goes here
    %% =================================================================================    
    p = inputParser;
    addRequired(p,'estimator')
    addRequired(p,'initial_fun_workspace')
    addRequired(p,'measurements')
    
    %% Parameters 
    parse(p,estimator,initial_fun_workspace,measurements,varargin{:})
    
    %ProcessNoise = initial_fun_workspace.ProcessNoise;
    %HightNoise   = initial_fun_workspace.HightNoise;

    BaroNoise    = initial_fun_workspace.BaroNoise;
    RSSNoise     = initial_fun_workspace.RSSNoise;
    ToFNoise     = initial_fun_workspace.ToFNoise;
    AoANoise     = initial_fun_workspace.AoANoise;
    InertialNoise = initial_fun_workspace.InertialNoise;
    
    %% =================================================================================    
        
       
    EKF_hight   = initial_fun_workspace.EKF_hight;
    EKF_xy      = initial_fun_workspace.EKF_xy; 

    predict(EKF_hight);
    for ims = measurements
        if strcmp(ims{:}.type,'Baro')
           correct(EKF_hight,ims{:}.values);
           break
        end
    end
    % Guardamos la altura predicha
    hestimada = EKF_hight.State(1);
    % Buscamos a que nivel podria coresponder la altura medida
    height_levels = [estimator.building.levels.height];
    [minvalue, min_index] = min(abs(height_levels - hestimada));
    n_current = min_index - 1;
    if minvalue < 1.0    
       EKF_hight.State(1) = height_levels(min_index);
       hestimada = EKF_hight.State(1);
    end
    
    if minvalue < 0.5 

        hight_level = height_levels(n_current+1);

        % Predecimos con el modelo de medidas
        % ===================================
        predict(EKF_xy,estimator.dt)          
        
        z = [];
        diagonal_noise = [];
        u = [];
        for  ims = measurements
            % medidas 
            if strcmp(ims{:}.type,'Baro')
               continue                 
            end
            if ismember('indexs_beacons',fieldnames(ims{:}))
                u = vec2mat([estimator.beacons(ims{:}.indexs_beacons).r],3);
            end
            z = [z ;ims{:}.values];
            switch ims{:}.type
                case 'RSS'
                typenoise = RSSNoise;
                case 'ToF'
                typenoise = ToFNoise;
                case 'AoA'
                typenoise = AoANoise;
                case 'InertialFoot'
                typenoise = InertialNoise;
            end
            diagonal_noise = [ diagonal_noise repmat(typenoise,1,length(ims{:}.values))];
        end
        % si hay beacons, es que hay medidas, por lo que deberemos corregir 
        % el vector de estado
        if ~isempty(u)
            EKF_xy.MeasurementNoise = diag(diagonal_noise);
            correct(EKF_xy,z,u,estimator) ;
        end  
    
    end  
    
    xestimada = EKF_xy.State(1);
    yestimada = EKF_xy.State(2);       
    result = [xestimada yestimada hestimada];
end

