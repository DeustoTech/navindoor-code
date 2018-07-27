
%% Plotting
% Muchos de los objectos creados en el *framework* tiene una funcion plot asociada, esto nos ayuda 
% a ver el objecto de una manera m�s amigable y ver el concepto que realmente representa. En este tutorial crearemos algunos objetos del m�dulo de planimetr�a para luego visualizarlos mediante gr�ficas 
%%
% Creamos 10 nodos aleatorios con la funci�n nativa de matlab *rand*
nodes = zeros(1,10,'node');
for iter = 1:10
   x = 50*rand;
   y = 50*rand;
   nodes(iter) = node([x y]);
end
%%
% Asi luce nuesta lista de nodos
nodes
%% 
% Si queremos ver lo que se ha realizado, utilicemos la funci�n *plot*. Ya que nodes un una lista de objectos *node*
% realmente al invocar a la funci�n *plot* el interprete de MATLAB esta llamando a la funci�n node/plot.
plot(nodes,'*');

%% 
% Ahora creemos 5 objectos *walls*
walls = zeros(1,10,'wall');
for iter = 1:5
   n1 = nodes(2*iter  );    % -- 2 4 6 8 10
   n2 = nodes(2*iter-1);    % -- 1 3 5 7 9
   walls(iter) = wall([n1 n2]);
end
%% 
% Podemos ver que para crear los objectos *wall*s hemos utilizado los nodos creados previamente. Veamos 
% nuestra lista *walls*
plot(walls)
%% La function Plot3, tambi�n disponible
plot3(nodes)
plot3(walls)
%% Objectos que heredan esta funcion
% Recordemos que todos los hijos de la clase *node* podr�n utilizar esta propiedad. 
plot(beacon([1 1]),'*');
%%
plot(door([1 1]),'*');
%%
plot(stairs([1 1]),'*');
%%
plot(elevator([1 1]),'*'); 
%% Objectos *level* y *build*
% Los objectos que reunen conglomeran estos objetos, para definir plantas y edificaciones tanbien pueden ser dibujadas 
% Creamos un nivel con las listas nodes y walls.
ilevel = level;
ilevel.nodes = nodes;
ilevel.walls = walls;
ilevel
%%
% Ve�moslo gr�ficamente
clf
plot(ilevel)
%%
new_ilevel = ilevel;
new_ilevel.n = 1;
ibuild = build([ilevel new_ilevel],[]);  % [] es una lista de objetos connection
%%
% Ve�moslo gr�ficamente
clf
plot(ibuild)
view(30,30)
grid on



