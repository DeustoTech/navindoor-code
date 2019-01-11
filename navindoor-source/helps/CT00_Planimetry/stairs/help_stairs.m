%%
% Create a stairs
st1 = stairs([10 10 1])
%%
st2 = stairs([10 20 1]);
st3 = stairs([0 10 1]);
%%
% Create a node
% You can initializate memory with this class
ListOfStairs = [st1 st2 st3]
%%
% And you can draw
line(ListOfStairs,'Marker','s')
xlim([-5 15])
ylim([0 30])
