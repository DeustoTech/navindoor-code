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
| type       | Mandatory          | char |('Baro','ToF','AoA') |
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
plot(building)
view(30,15)
grid on
%% 
% Mientras que el objeto _straj_ es una trayectoria dentro del edifício
% mecionado 
straj
%%
% Para poder generar la señal, es necesario que la trayectoria tenga una velocidad asociada.
straj = velocity(straj,building);
%% 
% Para crear un señal Baro de manera rápida, simplemente escribimos.
Baro_sgn = BeaconFreeSgn(straj,building,'Baro')
%% 

tline = timeline(straj);
% pressure array
pline = zeros(1,length(tline));

index = 0;
for t=tline
   index = index + 1;
   result = step(Baro_sgn,t);
   pline(index) = result.values;
end

clf
plot(tline,pline)
%%

