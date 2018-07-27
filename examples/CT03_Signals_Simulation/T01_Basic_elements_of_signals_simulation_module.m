
%% 
% Fecha de ultima revisi�n 15/05/2018
%%
% La secci�n de generaci�n de se�ales abarca distintos de tipo de se�ales, como pueden ser:
%%
% * RSS (Indicador de fuerza de la se�al recibida)
% * ToF (Tiempo de vuelo)
% * AoA (Angulo de llegada)
% * Giroscopio (_Giro_)
% * Magnet�metro (_Magne_)
% * Aceler�metro (_Acel_)
% * Bar�metro (_baro_)
%%
% Estas distintas se�ales se pueden dividir en dos tipos claramente diferenciados, estos son:
%%
% * *_BeaconBasedSgn_* (Se�ales basados en balizas) : Estos pueden ser por ejemplo: RSS, ToF o AoA; ya que es necesario conocer la posici�n 
% de estos puntos de acceso para poder simular la se�al. Con la posici�n de el objeto que queremos localizar y la posici�n de los puntos de acceso, nos 
% basta, sin embargo existen algunas caracter�sticas pueden depender de la planimetr�a o de alguna caracter�stica de la trayectoria en su conjunto. Es por ello que 
% a la hora de generar la se�al, existe una funci�n interna del constructor _BeaconBasedSgn_ que utiliza las variables de entrada: 
% _(index_beacon,index_node,ilevel,itraj,parameters)_. Esta funci�n es un parametr� por defecto, que puede ser modificado para utilizar el m�todo de simulaci�n 
% que se quiera. Por otra parte, en esta clase no se cuenta con las se�al entre plantas, ya que se ha decidido que por simplicidad, las se�ales  _BeaconBasedSgn_, ser�n
% nulas cuando halla transici�n entre plantas.
%
% * *_BeaconFreeSgn_* (Se�ales libres de balizas) : Por otra lado, existe otro tipo de se�ales que no dependen de balizas, por lo que su funcionamiento interno es distinto.
% Estos pueden ser el Giroscopio, Magnet�metro, Aceler�metro o el Bar�metro. De la misma forma que  _BeaconBasedSgn_, este constructor tiene una funci�n interna que genera la se�al 
% apartir de las variables de entrada: (index_inode,ilevel,itraj,parameters). Es decir, de el punto donde se este, de la planimetr�a, de la trayectoria total, y de par�metros 
% adicionales (usualmente usado para introducir la desviaci�n t�pica del ruido de la se�al). Por otra parte, en la transici�n entre plantas es necesario definir otra funci�n
% que nos diga como generar la se�al. Esta secci�n de se�al a diferencia a la se�al en una planta se genera de golpe, por una funci�n interna llamada _sgn_function_interlevel_. Esta funci�n 
% esta asignada por defecto, sin embargo tambien es modificable por un parametro llamado de la misma forma (sgn_function_interlevel)
%%
% En la secci�n S01 Examples, se ver� ejemplos de estas clases. Sin embargo en las secciones S02, S03, S04, S05 hay un explicaci�n m�s extensa.
%%
% Sin embargo, que algo m�s por decir. Dentro ya de una de los tipo de se�ales, existe un subtipo de se�al que es m�s b�sica. Esto se debe a que las se�ales 
% antes mencionadas, genera una se�al total, dado una trayectoria entre planta y por tanto a trav�s de un edif�cio. Sin embargo, primero se contruyo las clases que 
% solo utilizan una trayectoria en una misma planta, y la planta por donde trascurre. Estas se llaman igual que los constructores anteriores, pero con la palabra _Level_
% para indicar que solo se refiere a una planta. Estas son:
%%
% * *_BeaconBasedSgnLevel_* 
% * *_BeaconFreeSgnLevel_* 



%% Referencias 
% [1]  