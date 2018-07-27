
%%
% Fecha de ultima revisión 14/05/2018
%% Descripción
% La clase *BeaconFreeSgnLevel* es un objeto capaz de generar la una señal sintética independiente de  
% los puntos de acceso, dado una trayectoria y la planimetría del nivel por donde transcurre la trayectoria. 
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
 |  Parámeteros   | ¿Obligatorio?| Tipo de Variable  | Dimensión |  Opciones      | Valor por defecto                       |
 | :-----------:  | :-----------:| :---------------: | :-------: | :------------: |:--------------------------------------: |
 |  ilevel        | Obligatorio  | level             | [1x1]     |  Cualquiera    | [0 0]                                   |
 |  itraj         | Obligatorio  | traj              | [1x1]     |  Cualquiera    | 0                                       |
 |  type          | Obligatorio  | char              | [1x1]     | (Baro,Giro,Acel,Magno)| 'RSS'                                   |
 |  sgn_function  | Opcional     | function_handle   | [1x1]     |  Cualquiera    | (*@RSS_dftl*,*@ToF_dftl*,*@AoA_dftl*) * |
 |  parameters_sgn| Opcional     | cell              | [?x?]     |  Cualquiera    | ({2.0}, {1e-8},{0.1}) *                 |
 |  label         | Opcional     | char              | [1x1]     |  Cualquiera    | 'label'                                 |
 |  dt            | Opcional     | double            | [1x1]     |  Cualquiera    | 0.1                                     |

%}
%%
% \* Respectivamente al parámetro _type_.

%% Propiedades del objeto
%%
% * *ms*: Es una lista de objetos _ms_node_. Estas no es más que una estructura donde se guardan las medidas 
% de forma puntual, por lo que tiene asociado el tiempo en el que fueron medidos, los valores que se obtuvieron. La posicición donde se realizó la medida
% y el nivel donde estaba. Aunque existe la propiedad _index_beacons_ pero que dentro de esta clase no tiene sentido, por lo que no se usa.
ms_node
%%
% * *sgn_function*: función con la que fue generada la señal
% * *dim_signal*: Número de medidas dentro de los objetos _ms_node_
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
% Cargamos las variables necesarias para la ejecución del constructor
% BFSLevel
clear
load('data/levels/EI_UD_0.mat')
load('data/trajs/straj_in_conn_AP_fakes.mat')
itraj = straj.trajs(1);clear('straj')
whos
%%
% Los objetos *level* tiene una propiedad que lo caracteriza por altura.
% Podemos generar una señal de barometro gracias a esto. En este caso
% generamos una señal de barómetro de una primera planta.
['Altura: ',num2str(iurlevel.high),' m']
%% 
% Para crear una señal de barómetro dentro de un nivel, simplemente
% ejecutamos la siguiente linea de código.
Baro_sgn = BeaconFreeSgnLevel(itraj,iurlevel,'Baro')
%%
% Ya que la señal barómetro  es de caráter unidimensional, podemos verlo
line_values = [Baro_sgn.ms.values];
line_time = [Baro_sgn.ms.t];
plot(line_time,line_values)
xlabel('time(s)');ylabel('P(mmHg)');grid on
%% Ver más