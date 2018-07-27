function t=traj_network(net,vi,vf)
    % buscamos los vertices mas cercanos 
    distances = arrayfun(@(x) distn(x,vi),net.vertexs);
    [~,index_vi] = min(distances);
    distances = arrayfun(@(x) distn(x,vf),net.vertexs);
    [~,index_vf] = min(distances);

    % inicializamos la propiedad generacion de los vertices
    for index=1:length(net.vertexs)
        net.vertexs(index).generation = 0;
    end 

    % agregamos a las conecciones del vertices inicial a 
    % los posibles vertices 
    generation = 1;

    posibles = index_vi;
    net.vertexs(index_vi).generation = generation;
    revisados = [];
    %% 
    while true 
        generation = generation + 1; 
        % agregamos los nuevos posibles de las conenccione de los
        % anteriores 
        for index=posibles 
            for conn=net.vertexs(index).connections
                if ~ismember(conn,posibles) &&  ~ismember(conn,revisados)
                    posibles = [posibles conn];
                    net.vertexs(conn).generation = generation;
                end
            end
        end
        % comprobamos que exista algun posible valor
        if isempty(posibles)
            error('Imposible')
        end
        % comprobamos si es el primer vertice que estamos buscando
        if posibles(1) == index_vf
            break
        end 
        % no lo encontramos agregamos el vertices a revisados 
        revisados = [ revisados posibles(1)];
        % i lo quitamos de posibles 
        posibles(1) = [];
        % ordenamos los posibles valores para que el primero sea el
        % mas cercano al vertice final
        distances = arrayfun(@(x) distn(x,net.vertexs(index_vf)),net.vertexs(posibles));
        [~,indexs] = sort(distances);
        posibles = posibles(indexs);
    end 

    t = net.vertexs(posibles(1));
    while generation >= 1
        generation = t(end).generation -1 ;
        nn = t(end).connections;
        for n=nn
            if generation == net.vertexs(n).generation 
                t = [t net.vertexs(n)];
                break
            end
        end
        if t(end) == net.vertexs(index_vi)
           break 
        end
    end
    if length(t) < 2
        error('No se ha encontrado ruta')
    else
        t = traj(t);
    end
end
