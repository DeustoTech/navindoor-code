
%% 
% Fecha de ultima revisión 15/05/2018
%%
% La sección de generación de señales abarca distintos de tipo de señales, como pueden ser:
%%
% * RSS (Indicador de fuerza de la señal recibida)
% * ToF (Tiempo de vuelo)
% * AoA (Angulo de llegada)
% * Giroscopio (_Giro_)
% * Magnetómetro (_Magne_)
% * Acelerómetro (_Acel_)
% * Barómetro (_baro_)
%%
% Estas distintas señales se pueden dividir en dos tipos claramente diferenciados, estos son:
%%
% * *_BeaconBasedSgn_* (Señales basados en balizas) : Estos pueden ser por ejemplo: RSS, ToF o AoA; ya que es necesario conocer la posición 
% de estos puntos de acceso para poder simular la señal. Con la posición de el objeto que queremos localizar y la posición de los puntos de acceso, nos 
% basta, sin embargo existen algunas características pueden depender de la planimetría o de alguna característica de la trayectoria en su conjunto. Es por ello que 
% a la hora de generar la señal, existe una función interna del constructor _BeaconBasedSgn_ que utiliza las variables de entrada: 
% _(index_beacon,index_node,ilevel,itraj,parameters)_. Esta función es un parametró por defecto, que puede ser modificado para utilizar el método de simulación 
% que se quiera. Por otra parte, en esta clase no se cuenta con las señal entre plantas, ya que se ha decidido que por simplicidad, las señales  _BeaconBasedSgn_, serán
% nulas cuando halla transición entre plantas.
%
% * *_BeaconFreeSgn_* (Señales libres de balizas) : Por otra lado, existe otro tipo de señales que no dependen de balizas, por lo que su funcionamiento interno es distinto.
% Estos pueden ser el Giroscopio, Magnetómetro, Acelerómetro o el Barómetro. De la misma forma que  _BeaconBasedSgn_, este constructor tiene una función interna que genera la señal 
% apartir de las variables de entrada: (index_inode,ilevel,itraj,parameters). Es decir, de el punto donde se este, de la planimetría, de la trayectoria total, y de parámetros 
% adicionales (usualmente usado para introducir la desviación típica del ruido de la señal). Por otra parte, en la transición entre plantas es necesario definir otra función
% que nos diga como generar la señal. Esta sección de señal a diferencia a la señal en una planta se genera de golpe, por una función interna llamada _sgn_function_interlevel_. Esta función 
% esta asignada por defecto, sin embargo tambien es modificable por un parametro llamado de la misma forma (sgn_function_interlevel)
%%
% En la sección S01 Examples, se verá ejemplos de estas clases. Sin embargo en las secciones S02, S03, S04, S05 hay un explicación más extensa.
%%
% Sin embargo, que algo más por decir. Dentro ya de una de los tipo de señales, existe un subtipo de señal que es más básica. Esto se debe a que las señales 
% antes mencionadas, genera una señal total, dado una trayectoria entre planta y por tanto a través de un edifício. Sin embargo, primero se contruyo las clases que 
% solo utilizan una trayectoria en una misma planta, y la planta por donde trascurre. Estas se llaman igual que los constructores anteriores, pero con la palabra _Level_
% para indicar que solo se refiere a una planta. Estas son:
%%
% * *_BeaconBasedSgnLevel_* 
% * *_BeaconFreeSgnLevel_* 



%% Referencias 
% [1]  