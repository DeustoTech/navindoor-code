
%% Objetos *traj* y *supertraj*
% Para la descripción de las trayectoria, se ha creado los objectos *traj* y *supertraj*. 
%% Clase traj
% La clase traj representa un trayectoria en una única planta. Esto se ha creado de esta forma para que los tramos en un 
% única planta sean independientes de la trayectoria total. De esta forma se puede invocar métodos que utilizan 
% únicamente un objecto *traj* y un objecto *level*, sin necesidad de recurrir a toda la planimetría del edificio
% (objecto *build*) y a la trayectoria entre planta. 
traj
%% Clase supertraj 
% Esta clase no es mas que una extensión de la clase *traj*. Este objecto define una trayectoria entre plantas. Así 
% como el objecto *traj* se complmentaba de un objeto *level*, el objecto *supertraj* se complementa del objecto 
% *build*
supertraj
