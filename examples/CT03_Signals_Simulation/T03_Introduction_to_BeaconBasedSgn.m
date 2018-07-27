%% 
% La clase _BeaconsBasedSgn_, es la evolución de la clase _BBSLevel_.
% Mientras que _BBSLevel_ toma como variables de entrada un objeto _traj_ y
% un objeto _level_, _BeaconsBasedSgn_ toma como variables de entrada un
% objeto _supertraj_ y un objeto _build_. Tiene muchas similitudes, sin
% embargo el este último, se tiene valores de señal entre plantas 

%{
| Input Vars | Mandotory/Optional | type | Options |
|------------|--------------------| -----|-------- |
| istraj     | Mandatory          | supertraj | - |
| ibuild     | Mandatory          | build| - |
| type       | Mandatory          | char |('RSS','ToF','AoA') |
%}

%% Ejemplo Básico
clear;
load('data/builds/EI_UD_conn_AP_fakes.mat')
load('data/trajs/straj_in_conn_AP_fakes.mat')
whos
%%
% Antes de nada veamos como son nuestras variables de entrada. La variable
% _building_, es un edifício de 5 plantas, 
building
%% 
% Mientras que el objeto _straj_ es una trayectoria dentro del edifício
% mecionado 
straj
%%
% Para poder generar la señal, es necesario que la trayectoria tenga una velocidad asociada.
straj = velocity(straj,building);
%% 
% Para crear un señal RSS de manera rápida, simplemente escribimos.
RSS_sgn = BeaconBasedSgn(straj,building,'RSS')
%% 
% Este objeto contiene una lista de clases _BBSLevel_, estas propiedades
% describen el recorrido de la trayectoria en cada planta.
%%
% Podemos extraer tables de cada nivel, donde el número de columna es igual
% al número de _beacons_ en cada planta, mientras que las filas representan
% los distintos instantes de tiempo
% 
tables = signal2table(RSS_sgn)
%%
% Extraemos la tabla del primer tramo recorrido.
tbl1 = tables.inlevel{1};
tbl1(1:5,:)
%%
% Podemos ver gráficamente la señal recibida durante el primer tramo.
plot(tbl1{:,1},tbl1{:,2:end})
xlabel('time(s)');ylabel('Attenuation');title('RSS signal')
%%
% La clase _BeaconBasedSgn_ cuenta con un método que devuelve el valor en
% cada instante, simpre y cuando el valor del tiempo este definido dentro
% de la señal
step(RSS_sgn,0)
%% 
% Obtenemos la señal requerida
step(RSS_sgn,22.3)
%%
% Obtenemos la señal requerida en otro instante de tiempo
step(RSS_sgn,22.5)
%%
% Hemos encontrado un tramo sin señal, esto ocurre durante los cambios de
% planta
step(RSS_sgn,32.5)
%%
% el número de _beacons_ que recibimos a cambiado, por lo que sabemos que
% hemos cambiado de planta
try
    step(RSS_sgn,1000.0)
catch msg_error
     msg_error
end
%%
% Por último, si no salimos del rango de definición, generaremos un error.

