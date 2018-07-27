
%% Objetos *traj* y *supertraj*
% Para la descripci�n de las trayectoria, se ha creado los objectos *traj* y *supertraj*. 
%% Clase traj
% La clase traj representa un trayectoria en una �nica planta. Esto se ha creado de esta forma para que los tramos en un 
% �nica planta sean independientes de la trayectoria total. De esta forma se puede invocar m�todos que utilizan 
% �nicamente un objecto *traj* y un objecto *level*, sin necesidad de recurrir a toda la planimetr�a del edificio
% (objecto *build*) y a la trayectoria entre planta. 
traj
%% Clase supertraj 
% Esta clase no es mas que una extensi�n de la clase *traj*. Este objecto define una trayectoria entre plantas. As� 
% como el objecto *traj* se complmentaba de un objeto *level*, el objecto *supertraj* se complementa del objecto 
% *build*
supertraj
