
%%
% Fecha de ultima revisión 16/05/2018
%% Descripción
% Utilizaremos el filtro de Kalman ya implementado en MATLAB, por el
% _Control System Toolbox_. En ete caso, veremos como se puede utilizar esta herramienta en nuestro caso concreto. Describiremos esta clase, sin embargo
% hay mucha más información en éste enlace: [extendedKalmanFilter](https://es.mathworks.com/help/control/ref/extendedkalmanfilter.html)
% El filtro de Kalman es un método de predicción de medidas, en el que se utiliza el conocimiento del comportamiento que puede serguir nuestro 
% sistema (modelo dinámico) y una serie de medidas que nos permiten estimar alguna variables del sistema. 
%
%%
% Suponiendo que `x` es la variable que queramos predecir, e `y` es un vector de medidas, las ecuación para hallar el siguiente valor es el siguiente.
%%
%{ 
$$ 
x[k] = f(x[k-1],w[k-1] ,u_s[k-1]) 
$$
%}
%%
%{ 
$$ 
y[k] = h(x[k], v[k] ,u_m[k])
$$
%}
%% Variables de entrada 
% Solo describiremos algunas de las variables de entrada de este filtro, ya que al ser una clase de otro _toolbox_ tiene su propia documentación
% de forma más extensa. Los parámetros principales son:
%% 
% * *StateTransitionFcn*: Es la la function f descrita en el apartado anterior. Esta función a partir de el vecotr de estado anterior 
% es capaz de generar el siguiente estado, siguiendo el modelo dinámico
% * *InitialState*: Como vemos durate todo el proceso de Kalman, se obtiene el vector de estado a partir de un anterior, es por ello qe necesitamos 
% que exista un estado inicial para empezar con el ciclo. 
% * *MeasurementFcn*: Es la función h descrita en el apartado anterior. Esta función es capaz de corregir el vector de estado dadas una medidas. 
% * *MeasurementNoise*: Matriz de covarianza que tienen las medidas.
% * *ProcessNoise*: Matriz de covarianza asociado al modelo dinámico.
%% Propiedades del Objeto
% Las propiedades con las que trabajarémos en este tutorial son las mismas que las descritas en las variables de entrada. Por las que simplemente
% las mencionamos sin necesidad de explicarlas.
%%
% * StateTransitionFcn
% * InitialState
% * MeasurementFcn
% * MeasurementNoise
% * ProcessNoise

%% Sintaxis
% Cargamos un objetos necesarios para la realización del ejercicio
clear;
load('data/builds/EI_UD_conn_AP_fakes.mat')
load('data/trajs/straj_in_conn_AP_fakes.mat')
%%
% Recogemos una sección de trayectoria y el nivel donde transcurre esta.
index_traj = 3;
itraj  = straj.trajs(index_traj);
ilevel = building.levels(itraj.level + 1);
%% 
% Creamos una señal RSS, con sus parámetros por defecto
iBBSL_RSS = BeaconBasedSgnLevel(itraj,ilevel,'RSS');


%% 
% Ya tenemos los objetos necesarios para empezar el ejemplo del Filtro de Kalman
clear('building');clear('straj');clear('index*')
whos
%%
% Podemos ver de forma gráfica la trayectoria que queremos estimar 
plot(ilevel)
hold on
plot(itraj)
xlim([50 150])
%%
% *Funcion de transición y de medidas*
%%
% En nuestro caso trabajaremos con un vector de estado tal que 
%%
%{
$$
x_{state} = [ x \ \  y \ \ v_{x} \ \ v_{y}]^T
$$
%}
%%
% En nuestro caso, la función f, es CT04S01_StateTransition
type CT04S01_StateTransition.m
%% 
% Esta función simplemente desarrolla predice es siguiente estado por el método de euler, y suponiendo que durante ese intervalo de tiempo
% la velocidad es constante.
%%
%{
$$
x(k) = x(k-1) + v_{x}(k-1)dt 
$$
%}
%%
%{
$$
y(k) = y(k-1) + v_{y}(k-1)dt \\
$$
%}
%%
%{
$$
v_{x}(k) = v_{x}(k-1) \\
$$
%}
%%
%{
$$
v_{y}(k) = v_{y}(k-1) \\
$$
%}
%%
% mientras que la función h, es  CT04S01_Measurement
type CT04S01_Measurement.m
%%
% dado el vector de estado, podemos calcular las distancias a todos los _beacons_
%%
% *Condiciones iniciales*
%%
% Tomamos el vector de estado que nos proporciona la trayectoria .

x0 = itraj.nodes(1).r(1);
y0 = itraj.nodes(1).r(2);
v0 = itraj.v(1);
v0x = v0*cos(itraj.angles(1));
v0y = v0*sin(itraj.angles(1));

initialStateGuess = [x0 y0 v0x v0y]'

%%
% *Constructor del Filtro de Kalman*
%%
% Para construir el filtro de Kalman simplemnete pasamos las funciones de transición y de medida; ademas de la condición inicial 
% del estado.
EKF = extendedKalmanFilter(@CT04S01_StateTransition,@CT04S01_Measurement,initialStateGuess)
EKF.StateTransitionJacobianFcn = @CT04S01_StateTransition_Jacobian;
EKF.MeasurementJacobianFcn     = @CT04S01_Measurement_Jacobian;
%% 
% *Covarianzas del de las  medidas y del modelo*
% 
sigma_m = 2.0;  % desviacion estandar de medicion de attenuacion
sigma_d = 5.0;  % desviacion estandar del modelo
%%
% Agregamos estas desviaciones, creando una matriz de covariancias
dt = iBBSL_RSS.dt;
total_beacon = length(iBBSL_RSS.beacons);
EKF.MeasurementNoise = diag(repmat(sigma_m^2,1,total_beacon));
EKF.MeasurementNoise

%%
%             
EKF.ProcessNoise = diag([(dt^4)/4 , dt^4/4  , dt^2  ,  dt^2]*sigma_d^2);
EKF.ProcessNoise
%% 
% *Método de ejecución*
%%
% Para ejecutar el filtro de Kalman, existe dos funciones llamadas _predict_ y _correct_. Mostraremos un ejemplo de funcionamiento

tf = itraj.t(end);
ti = 0;
time_line =ti:dt:tf;

%%
% En este caso las posiciones de los beacons no se modifican 
% por lo que lo guardaremos en una variable u, que será constante
% en todo el ciclo
u = vec2mat([iBBSL_RSS.beacons.r],2);
% creamos  un matriz donde estaran los valores estimados del vector de estado y otra donde guardaremos la distancia entre 
% el punto estimado y el punto real, en cada instante.
estimation = zeros(iBBSL_RSS.len,4);
error = zeros(iBBSL_RSS.len,1);

iter = 0;
% Empezamos el ciclo de predicciones y correcciones
for t = time_line    
    iter = iter + 1;
    
    % Predict
    % ==================
    % Predecimos el valor de la posición segun el modelo dinamico
    predict(EKF,dt)

    % create measurement
    % ==================
    result = step(iBBSL_RSS,t);
    values = result.values;
    % en este caso no hace falta recoger result.beacons 
    % ya que los beacons siempre son los mismo, ya que iBBSL_RSS
    % no ha sido filtrado. Comprobar que iBBSL_RSS.NumMaxAps == 0
    z = values'; % z debe se contravariante

    % correct position
    % =================
    correct(EKF,z,u)
    
    % save information
    % =================
    index_node = time2index(itraj,t);
    x_real = itraj.nodes(index_node).r(1);
    y_real = itraj.nodes(index_node).r(2);
   
    estimation(iter,:) = EKF.State';
    error(iter) =  abs(sqrt((estimation(iter,1) - x_real)^2 + (estimation(iter,2) - y_real)^2));

end
%%
% *Comportamiento del error*
figure()
hold on
[A,B] = ecdf(error);
[~,index_min] =min(abs(A-0.9));
title(['90 % ->',num2str(B(index_min)),'m'])
plot(B,A,'k')
grid on
%%
% *Trayectoria estimada*
%%
% La variable _estimation_, contiene la estimación que se ha hecho de la posición. Podemos compararla gráficamente con la trayectoria real. 
figure()
plot(itraj)
hold on 
plot(ilevel)
line(estimation(:,1),estimation(:,2),'Marker','.','Color','red')
xlim([50 150])
%%
% Tambien podemos ver las dos trayectoria las dos en una animación 

% Creamos una trayectoria a partir la la matriz _estimation_
itraj_estimation = mat2traj(estimation(:,1:2));
itraj_estimation.t = itraj.t;
itraj_estimation.v = sqrt(estimation(:,3).^2 + estimation(:,4).^2);
% agregamos 
itraj_estimation.label = 'Estimation';

itraj.label = 'Real';
% Escribir en la consola de MATLAB lo siguiente
% comparetraj([itraj_estimation itraj],'level',ilevel)
