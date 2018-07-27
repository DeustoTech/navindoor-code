function result = UKF_bucle(estimator,initial_fun_workspace,measurements,varargin)
%EKF_INIT Summary of this function goes here
%   Detailed explanation goes here
    %% =================================================================================    
    p = inputParser;
    addRequired(p,'estimator')
    addRequired(p,'initial_fun_workspace')
    addRequired(p,'measurements')
    
    addOptional(p,'ProcessNoise',diag([0.50 0.50 0.25 0.25]))
    addOptional(p,'HightNoise',0.50)
    
    addOptional(p,'BaroNoise',0.025)
    addOptional(p,'RSSNoise',1.0)
    addOptional(p,'ToFNoise',1e-17)
    addOptional(p,'AoANoise',1.0)

    
    %% Parameters 
    parse(p,estimator,initial_fun_workspace,measurements,varargin{:})
    
    ProcessNoise = p.Results.ProcessNoise;
    HightNoise   = p.Results.HightNoise;

    BaroNoise    = p.Results.BaroNoise;
    RSSNoise     = p.Results.RSSNoise;
    ToFNoise     = p.Results.ToFNoise;
    AoANoise     = p.Results.AoANoise;
    %% =================================================================================    
        
        
    UKF_hight  = initial_fun_workspace.EKF_hight;
    UKF_xy = initial_fun_workspace.EKF_xy; 

    predict(UKF_hight);
    for ims = measurements
        if strcmp(ims{:}.type,'Baro')
           correct(UKF_hight,ims{:}.values);
           break
        end
    end
    % Guardamos la altura predicha
    hestimada = UKF_hight.State(1);
    % Buscamos a que nivel podria coresponder la altura medida
    [minvalue, min_index] = min(abs(estimator.building.height_levels - hestimada));
    n_current = min_index - 1;
    if minvalue < 1.0    
       UKF_hight.State(1) = estimator.building.height_levels(min_index);
       hestimada = UKF_hight.State(1);
    end
    
    if minvalue < 0.5 

        hight_level = estimator.building.height_levels(n_current+1);

        % Predecimos con el modelo de medidas
        % ===================================
        predict(UKF_xy,estimator.dt)          
        
        z = [];
        diagonal_noise = [];
        u = [];
        for  ims = measurements
            % medidas 
            if strcmp(ims{:}.type,'Baro')
               continue                 
            end
            if ismember('beacons',fieldnames(ims{:}))
                if ~isempty(ims{:}.beacons)
                    u =  vec2mat([ims{:}.beacons.r],2);
                end
            end
            z = [z ims{:}.values];
            switch ims{:}.type
                case 'RSS'
                typenoise = RSSNoise;
                case 'ToF'
                typenoise = ToFNoise;
                case 'AoA'
                typenoise = AoANoise;
            end
            diagonal_noise = [ diagonal_noise repmat(typenoise,1,length(ims{:}.values))];
        end
        % si hay beacons, es que hay medidas, por lo que deberemos corregir 
        % el vector de estado
        if ~isempty(u)
            UKF_xy.MeasurementNoise = diag(diagonal_noise);
            %display(['medido: ',num2str(z)])
            correct(UKF_xy,z,u,estimator)  
        end  
    
    end  
    
    xestimada = UKF_xy.State(1);
    yestimada = UKF_xy.State(2);       
    result = [xestimada yestimada hestimada];
end

