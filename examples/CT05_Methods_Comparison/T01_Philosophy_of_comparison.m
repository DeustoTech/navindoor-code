
%%
% Fecha de ultima revisión 21/06/2018

%%
% Para la comparación de métodos, hay que entendér que todas las funciones que se puede realizar 
% a una objecto supertraj, se puede aplicar para una lista de objectos supertraj
%% 
% Es por ello, que el módulo de comparación de métodos, no es más que la extensión de los 
% métodos que ya se pueden hacer a una supertrayectoria, a una lista de supertrayectorias 
%%
% Por ejemplo la funcion animation, se puede ejecutar 
%% 
%animation( supertraj_object , building_object)
%%
% Si tenemos varias supertrayectorias con la misma timeline, entonces podemos realizar
% la animación de varias *supertraj*s
%% 
%animation( [ supertraj_object_1 supertraj_object_2 ] , building_object)
%% 
% de la misma forma que la función ecdf, que nos muestra la función de distribución 
% de acumulación del error puede ser invocada 
%ecdf(straj_reference, supertraj_object ])
%% 
% Sin embargo, tambien se pueden ver los errores para dos trayectorias 
% Utilizando el objecto *straj_reference*, como trayectoria real.
%ecdf(straj_reference, [ supertraj_object_1 supertraj_object_2 ])
