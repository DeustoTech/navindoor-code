%%
% El módulo de planimetría se centra en la construcción de la estructuras MATLAB, que representan un edifício. Un edifício
% esta representado por una serie de objectos definidos dentro del framework. Aunque, esta representación tiene el problema
% de ser poco versatis ante código externo, es muy útil para crear una funcional y coperatividad entre todos los elementos 
% del software.
% 
%% Builds
% *luild* es el elemento que representa un edifício en su totalidad. Contiene una lista de objetos *Level*, que será
% explicado a continuación 
%
build
%% Levels
% *level* es el objeto que representa una planta. Este objeto contiene toda la información relacionada de la planta. 
% Y aunque es una parte de el objeto *build*, existe muchos métodos propios de este objeto. Es decir, que si se prefiere 
% trabajar con el elemento *Level*, es posible. Ya que se comporta de manera independiente.
%
level
%% Nodes, Doors, Beacons, Stairs, Elevators
% *node* es elemento más básico del framework. Especifica la posición dentro de una planta de un punto. Además contiene 
% la planta donde se encuentra el nodo. 
%
node
%%
% Notar que esta última propiedad solo puede ser entero. 
%%
% Los objetos  Doors, Beacons, Stairs, Elevators, son hijos de la clase node, lo que quiere decir que hereda todos sus 
% métodos y propiedades.
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
