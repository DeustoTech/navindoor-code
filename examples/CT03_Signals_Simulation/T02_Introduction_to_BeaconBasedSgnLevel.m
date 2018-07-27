
%%
% Fecha de ultima revisi�n 15/05/2018
%% Descripci�n
% La clase *BeaconBasedSgnLevel* es un objeto capaz de generar la una se�al sint�tica dependiente de  
% los puntos de acceso, dado una trayectoria y la planimetr�a del nivel por donde transcurre. 
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
 |  Par�meteros   | �Obligatorio?|�Tipo de Variable  | Dimensi�n |  Opciones      |     Valor por defecto                     |
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
% \* Respectivamente al par�metro _type_.

%% Propiedades del objeto
%%
% * *ms*: Es una lista de objetos _ms_node_. Estas no es m�s que una estructura donde se guardan las medidas 
% de forma puntual, por lo que tiene asociado el tiempo en el que fueron medidos, los valores que se obtuvieron, los �ndices de los beacons 
% de donde se obtuvieron los valores. La posicici�n donde se realiz� la medida y el nivel donde estaba. 
ms_node
%%
% * *sgn_function*: funci�n con la que fue generada la se�al
% * *beacons*: Lista de beacons que se utilizaron para generar la funci�n. Recordar que los �ndices descritos en la propiedad de los _ms_node_ s hacen 
% referencia al orden de esta lista de _beacons_. 
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
% Generamos una distribuci�n beacons, lo colocamos dentro de una nivel *ilevel* y generamos una trayectoria. Estos son los elementos b�sicos
% para la generaci�n de una se�al.
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
% Como en esta entrada la generaci�n de la velocidad no 
% es de especial inter�s, simplemente nos limitaremos a 
% ejecutar lo siguiente:
itraj = velocity(itraj);
itraj
%%
% *Ejecucion del constructor BBSLevel*
%%
% En este primer ejempo simularemos una se�al tipo RSS, ejecutando el siguiente 
% comando:
RSS_signal = BeaconBasedSgnLevel(itraj,ilevel,'RSS')
%%
% La se�al contiene mucha informaci�n, podemos ver el primer instante de tiempo de la siguiente forma:
RSS_signal.ms(1)
%%
% Sabemos que el indice 1, corresponde al t = 0. Ya que el tiempo de mustreo es constante, podemos calcular el �ndice donde
% se encuentra un determinado  instante de tiempo. Sin embargo, tambien se puede utilizar la funci�n *step* para este fin. 
step(RSS_signal,0)
%%
% Estos valores son la atenuaci�n de los *beacons* definidos en el nivel. 
% Los valores siguen el orden que tiene los objetos *beacon* dentro de la estructura
% *ilevel*
%%
% Podemos extraer una tabla con valores en cada instante de tiempo con la funci�n 
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
% Obtenemos la evoluci�n temporal de la se�al de los distintos *beacons*
%% Ver m�s 
% Este clase tiene los m�todos:
methods(BeaconBasedSgnLevel,'-full')