function result = scale(obj,x,y)
    % Vectorizacion del metodo
    result= arrayfun(@(var) scale1(var,x,y),obj);
    % Scala un vector definido por las cordenadas del nodo
    function new_node=scale1(obj,x,y)
       xnew = obj.r(1)*x;
       ynew = obj.r(2)*y;
       % Mantiene la clase del objeto: node, vertex, door, ...
       fun=str2func(class(obj));
       new_node = fun([xnew ynew]);
       new_node.level = obj.level;
    end
end