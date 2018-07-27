
%%
% Fecha de ultima revisi�n 14/05/2018
%% Descripci�n
% La clase *BeaconFreeSgnLevel* es un objeto capaz de generar la una se�al sint�tica independiente de  
% los puntos de acceso, dado una trayectoria y la planimetr�a del nivel por donde transcurre la trayectoria. 
% 
%% Variables de entrada 
% * *ilevel*     - Posicion bidimiensional de el nodo dentro de un plano. 
% * *itraj* - Nivel donde se encuentra el nodo. 
% * *type* - Cadena de car�teres que �ndica de que tipo de se�al estamos hablando
% * *sgn_function* - Funcci�n handle que se utiliza para el c�lculo de la se�al. El valor por defecto de esta variable depende de la 
% variable _type_, debido que que la generaci�n de estas se�ales son muy distintas. Esta funci�n tiene como par�metros de 
% entrada _(index_beacon,index_node,ilevel,itraj,parameters)_. _index_beacon_ y _index_node_ hace referencia del nodo/beacons dentro del nivel
% y la trayectoria respectivamente. en _parameters_ puede ser cualquier dato, ya que esta ser� la variable _parameters_sgn_
% contralado por el constructor directamente. 
% * *parameters_sgn* - Este par�metro tiene relacion directa con el parametro _parameters_ de la funci�n handle *sgn_function*.
% * *label* - Nombre de la se�al 
% * *dt* - Tiempo entre medida y medida. Notar que esta se�al esta equiespaciada en el tiempo.

%{
 |  Par�meteros   | �Obligatorio?|�Tipo de Variable  | Dimensi�n |  Opciones      | Valor por defecto                       |
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
% \* Respectivamente al par�metro _type_.

%% Propiedades del objeto
%%
% * *ms*: Es una lista de objetos _ms_node_. Estas no es m�s que una estructura donde se guardan las medidas 
% de forma puntual, por lo que tiene asociado el tiempo en el que fueron medidos, los valores que se obtuvieron. La posicici�n donde se realiz� la medida
% y el nivel donde estaba. Aunque existe la propiedad _index_beacons_ pero que dentro de esta clase no tiene sentido, por lo que no se usa.
ms_node
%%
% * *sgn_function*: funci�n con la que fue generada la se�al
% * *dim_signal*: N�mero de medidas dentro de los objetos _ms_node_
% * *label*: Simplemente sirve par nombrar, la se�al. Esta propiedad esta pensada, para utilizarla enla leyenda la hora de dibujar la se�al, sin embargo 
% todav�a no esta implementada esta funci�n.
% * *type*: Describe es tipo de se�al generada.
% * *dt*: Tiempo de muestreo, o intervalo de tiempo entre medida y medida
% * *NumMaxAps*: Existe una funci�n que puede filtrar un n�mero maximo de puntos de acceso. Por lo que solo se tomam algunas medidas de _ms_nodes.values_. Si el valor 
% de esta propiedad es nulo, quiere decir que no se ha filtrado. 
% * *direction*: Orden de los valores por el que ha sido filtrada la se�al. Si no se ha aplicado ning�n filtro, el valor es 'none'.
% * *orderby*: Por que tipo de se�al ha sido filtrada la se�al. Si no ha sido filtrada, tendr� un valor de 'none'. En general, las se�ales ser�n filtradas
% por una se�al RSS, ya que el nivel de potencia indica que tanto nos podemos fiar de la se�al, pero tambien se puede utilizar el tiempo de vuel o cualquier otro que se te ocurra.
% * *len*:  N�mero de medidas en la se�al
%% Sintaxis 
% Cargamos las variables necesarias para la ejecuci�n del constructor
% BFSLevel
clear
load('data/levels/EI_UD_0.mat')
load('data/trajs/straj_in_conn_AP_fakes.mat')
itraj = straj.trajs(1);clear('straj')
whos
%%
% Los objetos *level* tiene una propiedad que lo caracteriza por altura.
% Podemos generar una se�al de barometro gracias a esto. En este caso
% generamos una se�al de bar�metro de una primera planta.
['Altura: ',num2str(iurlevel.high),' m']
%% 
% Para crear una se�al de bar�metro dentro de un nivel, simplemente
% ejecutamos la siguiente linea de c�digo.
Baro_sgn = BeaconFreeSgnLevel(itraj,iurlevel,'Baro')
%%
% Ya que la se�al bar�metro  es de car�ter unidimensional, podemos verlo
line_values = [Baro_sgn.ms.values];
line_time = [Baro_sgn.ms.t];
plot(line_time,line_values)
xlabel('time(s)');ylabel('P(mmHg)');grid on
%% Ver m�s