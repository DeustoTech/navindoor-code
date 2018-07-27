
%%
% Fecha de ultima revisión 28/05/2018
%%
% Cargamos un objetos necesarios para la realización del ejercicio
clear;
load('data/builds/EI_UD_conn_AP_fakes_more_APS.mat')
load('traj_p1.mat')
%load('prueba.mat')
%% 
straj = velocity(straj,building)

% Creamos una señal RSS, con sus parámetros por defecto
iRSS   = BeaconBasedSgn(straj,building,'RSS');
iBaro  = BeaconFreeSgn(straj,building,'Baro');
iToF   = BeaconBasedSgn(straj,building,'ToF');
%%
% creamos del filtro de kalman vector de estado inicial 
% [x y vx vy h]
u0 = step(straj,0,'velocity',true,'hight',true);
h0 = u0.h;
u0 =  [u0.x ; u0.y ; 0 ; 0 ];
n0 = min(abs(building.height_levels - h0));
dt = straj.dt;

%% level
UKF_hight = UKF(@(h) [h(1)+dt*h(2) ; h(2)]    , ... % funcion de trancision
                @(h) hight2pressure(h(1))     , ... % funcion de medidas
                [h0;0]);                            % condicion inicial
% asignamos la varianza correspondientes
UKF_hight.MeasurementNoise = 0.025;
% Dando la mis inportancia a las medidas que al modelo.
UKF_hight.ProcessNoise     = diag([0.0125  0.0125^2]);
%% traj
UKF_xy = UKF(@StateTransition,  ...
             @Measurement,      ...
             u0);
         
UKF_xy.ProcessNoise = diag([0.5 0.5 0.5^2 0.5^2]);
RSS_noise = 2.0;ToF_noise =1e-8;

index = 0;

% simulación en el tiempo
tline = timeline(straj);
estimation = zeros(length(tline),6); % [x y h vx vy t]

for t = tline
    index = index + 1;
    % Medida del Barometro
    % =====================
    result = step(iBaro,t);
    % Reducimos ruido con un filtro de Kalman
    predict(UKF_hight);
    vector_hight = correct(UKF_hight,result.values);
    % Guardamos la altura predicha
    hestimada = vector_hight(1);
    % Buscamos a que nivel podria coresponder la altura medida
    [minvalue, min_index] = min(abs(building.height_levels - hestimada));
    n_current = min_index - 1;
    
    %  consideramos que estamos en una planta
    if minvalue < 0.5 
            % ALtura en la planta
            hight_level = building.height_levels(n_current+1);
            % Predecimos con el modelo de medidas
            % ===================================
            predict(UKF_xy,dt)                           

            % Medida de ToF y RSS 
            % ====================
            % Medimos las señales
            result_RSS = step(iRSS,t);
            result_ToF = step(iToF,t);
            if ~isempty(result_RSS.values)
                % AP position
                u = vec2mat([result_RSS.beacons.r],2); 
                % Construimos vector de medidas
                z = [result_RSS.values';result_ToF.values'];
                % Matrix de covarianza de medidas
                UKF_xy.MeasurementNoise = diag([ repmat(RSS_noise,1,length(result_RSS.values))  ... % atualizamos las dimensiones de la 
                                                 repmat(ToF_noise,1,length(result_ToF.values)) ]);  % matrix de covarianza del modelo de 
                % Corregimos                                                                         % medidas
                % ===================
                correct(UKF_xy,z,u)  
            end

            % Guardamos la posicion estimada 
            % ==============================
            x = UKF_xy.State(1); y = UKF_xy.State(2); vx = UKF_xy.State(3); vy = UKF_xy.State(4);
            h = hight_level;
            % formateamos
            estimation(index,:) = [x y h vx vy t];
    else
    %  consideramos que estamos en la transicion de una planta
            ilevel = building.levels(n_current + 1);
            h = hestimada;
            inode = node([x y]);
            min_s = Inf; min_e = Inf;
            
            staris = ilevel.stairs;
            if ~isempty(staris)
                distance_stairs = distn(inode,staris);
                [min_s , ind_s] = min(distance_stairs);
            end
            elevators = ilevel.elevators;
            if ~isempty(elevators)
                distance_elevator = distn(inode,elevators);
                [min_e , ind_e] = min(distance_elevator);
            end

            if min_e < min_s
                x = ilevel.elevators(ind_e).r(1);
                y = ilevel.elevators(ind_e).r(2);
            else
                x = ilevel.stairs(ind_s).r(1);
                y = ilevel.stairs(ind_s).r(2);
            end
            vx = 0; vy = 0;
            % Guardamos la posicion estimada 
            % ==============================
            % formateamos
            estimation(index,:) = [x y h vx vy t];  
            UKF_xy.State = [x y vx vy];
    end
               
end

esti_straj_UKF = mat2supertraj(estimation,building);


%animation([straj esti_straj_UKF  ],building,'xx',5.0)

ecdf(straj,esti_straj_UKF)



%%
function x_new = StateTransition(x,dt)
%STATETRANSITION 
% 
    
    F = [ 1 0 dt 0  ; ...
          0 1 0  dt ; ...
          0 0 1  0  ; ... 
          0 0 0  1  ];
      
    x_new = F*x;
end

function y = Measurement(x,u) %h(s)
%MEASUREMENT 
%  u = matrix [mx2] of beacons positions 
%  x = matrix [nx1], [x,y,vx,vy]  
%  
    c = 3e8;

    [nbeacon,~] = size(u);
    y = zeros(2*nbeacon,1);
    y(1:nbeacon)     = 10*log10(sqrt((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2));
    y(nbeacon+1:end) = sqrt((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2)/c;
    
end
