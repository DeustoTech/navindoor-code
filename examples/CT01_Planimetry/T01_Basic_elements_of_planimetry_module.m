%%
% El m�dulo de planimetr�a se centra en la construcci�n de la estructuras MATLAB, que representan un edif�cio. Un edif�cio
% esta representado por una serie de objectos definidos dentro del framework. Aunque, esta representaci�n tiene el problema
% de ser poco versatis ante c�digo externo, es muy �til para crear una funcional y coperatividad entre todos los elementos 
% del software.
% 
%% Builds
% *luild* es el elemento que representa un edif�cio en su totalidad. Contiene una lista de objetos *Level*, que ser�
% explicado a continuaci�n 
%
build
%% Levels
% *level* es el objeto que representa una planta. Este objeto contiene toda la informaci�n relacionada de la planta. 
% Y aunque es una parte de el objeto *build*, existe muchos m�todos propios de este objeto. Es decir, que si se prefiere 
% trabajar con el elemento *Level*, es posible. Ya que se comporta de manera independiente.
%
level
%% Nodes, Doors, Beacons, Stairs, Elevators
% *node* es elemento m�s b�sico del framework. Especifica la posici�n dentro de una planta de un punto. Adem�s contiene 
% la planta donde se encuentra el nodo. 
%
node
%%
% Notar que esta �ltima propiedad solo puede ser entero. 
%%
% Los objetos  Doors, Beacons, Stairs, Elevators, son hijos de la clase node, lo que quiere decir que hereda todos sus 
% m�todos y propiedades.
%% 
% *doors* 
door
%% 
% *beacon* 
beacon
%%
% *stairs* 
stairs
%% 
% *elevators* 
elevators
%%
