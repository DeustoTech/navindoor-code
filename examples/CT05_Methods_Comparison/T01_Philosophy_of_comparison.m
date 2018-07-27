
%%
% Fecha de ultima revisi�n 21/06/2018

%%
% Para la comparaci�n de m�todos, hay que entend�r que todas las funciones que se puede realizar 
% a una objecto supertraj, se puede aplicar para una lista de objectos supertraj
%% 
% Es por ello, que el m�dulo de comparaci�n de m�todos, no es m�s que la extensi�n de los 
% m�todos que ya se pueden hacer a una supertrayectoria, a una lista de supertrayectorias 
%%
% Por ejemplo la funcion animation, se puede ejecutar 
%% 
%animation( supertraj_object , building_object)
%%
% Si tenemos varias supertrayectorias con la misma timeline, entonces podemos realizar
% la animaci�n de varias *supertraj*s
%% 
%animation( [ supertraj_object_1 supertraj_object_2 ] , building_object)
%% 
% de la misma forma que la funci�n ecdf, que nos muestra la funci�n de distribuci�n 
% de acumulaci�n del error puede ser invocada 
%ecdf(straj_reference, supertraj_object ])
%% 
% Sin embargo, tambien se pueden ver los errores para dos trayectorias 
% Utilizando el objecto *straj_reference*, como trayectoria real.
%ecdf(straj_reference, [ supertraj_object_1 supertraj_object_2 ])
