
%%
% Fecha de ultima revisión 15/05/2018
%% Descripción
% La clase *BeaconBasedSgnLevel* es un objeto capaz de generar la una señal sintética dependiente de  
% los puntos de acceso, dado una trayectoria y la planimetría del nivel por donde transcurre. 
% 
%% Variables de entrada 
% * *ilevel*     - Posicion bidimiensional de el nodo dentro de un plano. 
% * *itraj* - Nivel donde se encuentra el nodo. 
% * *type* - Cadena de caráteres que índica de que tipo de señal estamos hablando
% * *sgn_function* - Funcción handle que se utiliza para el cálculo de la señal. El valor por defecto de esta variable depende de la 
% variable _type_, debido que que la generación de estas señales son muy distintas. Esta función tiene como parámetros de 
% entrada _(index_beacon,index_node,ilevel,itraj,parameters)_. _index_beacon_ y _index_node_ hace referencia del nodo/beacons dentro del nivel
% y la trayectoria respectivamente. en _parameters_ puede ser cualquier dato, ya que esta será la variable _parameters_sgn_
% contralado por el constructor directamente. 
% * *parameters_sgn* - Este parámetro tiene relacion directa con el parametro _parameters_ de la función handle *sgn_function*.
% * *label* - Nombre de la señal 
% * *dt* - Tiempo entre medida y medida. Notar que esta señal esta equiespaciada en el tiempo.

%{
 |  Parámeteros   | ¿Obligatorio?| Tipo de Variable  | Dimensión |  Opciones      |     Valor por defecto                     |
 | :-----------:  | :-----------:| :---------------: | :-------: | :------------: |:----------------------------------------: |
 |  ilevel        | Obligatorio  | level             | [1x1]     |  Cualquiera    | [0 0]                                     |
 |  itraj         | Obligatorio  | traj              | [1x1]     |  Cualquiera    | 0                                         |
 |  type          | Obligatorio  | char              | [1x1]     |  (RSS,ToF,AoA) | 'RSS'                                     |
 |  sgn_function  | Opcional     | function_handle   | [1x1]     |  Cualquiera    | (*@RSS_dftl*,*@ToF_dftl*,*@AoA_dftl*) *   |
 |  parameters_sgn| Opcional     | cell              | [?x?]     |  Cualquiera    | ({2.0}, {1e-8},{0.1}) *                   |
 |  label         | Opcional     | char              | [1x1]     |  Cualquiera    | 'label'                                   |
 |  dt            | Opcional     | double            | [1x1]     |  Cualquiera    | 0.1                                       |

%}
%%
% \* Respectivamente al parámetro _type_.

%% Propiedades del objeto
%%
% * *ms*: Es una lista de objetos _ms_node_. Estas no es más que una estructura donde se guardan las medidas 
% de forma puntual, por lo que tiene asociado el tiempo en el que fueron medidos, los valores que se obtuvieron, los índices de los beacons 
% de donde se obtuvieron los valores. La posicición donde se realizó la medida y el nivel donde estaba. 
ms_node
%%
% * *sgn_function*: función con la que fue generada la señal
% * *beacons*: Lista de beacons que se utilizaron para generar la función. Recordar que los índices descritos en la propiedad de los _ms_node_ s hacen 
% referencia al orden de esta lista de _beacons_. 
% * *label*: Simplemente sirve par nombrar, la señal. Esta propiedad esta pensada, para utilizarla enla leyenda la hora de dibujar la señal, sin embargo 
% todavía no esta implementada esta función.
% * *type*: Describe es tipo de señal generada.
% * *dt*: Tiempo de muestreo, o intervalo de tiempo entre medida y medida
% * *NumMaxAps*: Existe una función que puede filtrar un número maximo de puntos de acceso. Por lo que solo se tomam algunas medidas de _ms_nodes.values_. Si el valor 
% de esta propiedad es nulo, quiere decir que no se ha filtrado. 
% * *direction*: Orden de los valores por el que ha sido filtrada la señal. Si no se ha aplicado ningún filtro, el valor es 'none'.
% * *orderby*: Por que tipo de señal ha sido filtrada la señal. Si no ha sido filtrada, tendrá un valor de 'none'. En general, las señales serán filtradas
% por una señal RSS, ya que el nivel de potencia indica que tanto nos podemos fiar de la señal, pero tambien se puede utilizar el tiempo de vuel o cualquier otro que se te ocurra.
% * *len*:  Número de medidas en la señal
%% Sintaxis
% Generamos una distribución beacons, lo colocamos dentro de una nivel *ilevel* y generamos una trayectoria. Estos son los elementos básicos
% para la generación de una señal.
clear;
ilevel = level;
mt = [15 15;35 35;15 35;35 15];
beacons = mat2nodes(mt,'beacon'); % desde matrix a lista de beacons
ilevel.beacons = beacons; 
% creamos una trayectoria dentro de este nivel. Nos inventamos una curva dentro de la planta
x = 10:0.1:40;
y = x + 2.5*sin(x);
% creamos una objecto tipo traj, apartir de una matrix [x' y'] 
itraj = mat2traj([x' y']);
% Veamos los objetos construidos
plot(ilevel)
hold on
plot(itraj)
%%
% Es necesario generar la velocidad de esta trayectoria. 
% Como en esta entrada la generación de la velocidad no 
% es de especial interés, simplemente nos limitaremos a 
% ejecutar lo siguiente:
itraj = velocity(itraj);
itraj
%%
% *Ejecucion del constructor BBSLevel*
%%
% En este primer ejempo simularemos una señal tipo RSS, ejecutando el siguiente 
% comando:
RSS_signal = BeaconBasedSgnLevel(itraj,ilevel,'RSS')
%%
% La señal contiene mucha información, podemos ver el primer instante de tiempo de la siguiente forma:
RSS_signal.ms(1)
%%
% Sabemos que el indice 1, corresponde al t = 0. Ya que el tiempo de mustreo es constante, podemos calcular el índice donde
% se encuentra un determinado  instante de tiempo. Sin embargo, tambien se puede utilizar la función *step* para este fin. 
step(RSS_signal,0)
%%
% Estos valores son la atenuación de los *beacons* definidos en el nivel. 
% Los valores siguen el orden que tiene los objetos *beacon* dentro de la estructura
% *ilevel*
%%
% Podemos extraer una tabla con valores en cada instante de tiempo con la función 
tbl = signal2table(RSS_signal);
tbl(1:5,:)
%%
% representando esta tabla:
clf
plot(tbl{:,1},tbl{:,2:5})
xlabel("time")
ylabel("attenuation")
legend(strcat("beacon-",num2str((1:4)','%0.2d')))
%%
% Obtenemos la evolución temporal de la señal de los distintos *beacons*
%% Ver más 
% Este clase tiene los métodos:
methods(BeaconBasedSgnLevel,'-full')