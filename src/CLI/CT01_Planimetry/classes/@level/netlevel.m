function net=netlevel(level,maxstep,additional_vertexs,potential)
    %% Generate network of level
    % INPUTS:
    %   - level:        level that gives the restictions 
    %   - maxstep:      maximum distances between vertices
    % 
    % OUTPUTS:
    %   - network or networks of levels

    nets = [];
    %% 
    % creamos una red por cada puertas que exista en el nivel 
    % cada vertices padres de las redes creadas tendra las 
    % coordenadas de sus respectivas puertas.
    for idoors=level.doors
        net = network(maxstep);
        d = vertex(idoors.r);
        add(net,d,0);
        nets = [nets net];
    end
    %%
    % anadimos la informacion adicional 
    level.widthwalls = 1.0;
    switch nargin
        case 2 
            potential = potlevel(level,0.2);
        case 3
            potential = potlevel(level,0.2);
            for ivertex=additional_vertexs
                net = network(maxstep);
                add(net,ivertex,0);
                nets = [nets net];
            end
        case 4
             for ivertex=additional_vertexs
                net = network(maxstep);
                add(net,ivertex,0);
                nets = [nets net];
            end               
    end

    maxiter = 2000;
    iter = 0;
    fin = false;
    %% 
    % realizamos el siguiente bucle hasta que tengamos una sola red
    while ~fin
        %% 
                 plot(level)
                 hold on
                 for net=nets 
                     plot(net.branchs);
                 end
                 plot(ivertex,'*')
                 clf
        % expandimos las redes dado un vertice aleatorio
        ivertex = randpotential(level,potential,'vertex');
        for net=nets 
            tryexpand(net,potential,ivertex);
        end


        %%
        % tratamos de unir las redes si se ha generado un mismo vertice 
        % para dos de ellas. Relizamos esto hasta que no existan un mismo 
        % vertice para dos redes.
        change = true;
        while change
            change = false;
            for i=1:length(nets)
                for j=1:length(nets)
                    if i ~= j
                        if nets(i).vertexs(end) == nets(j).vertexs(end)
                            new_net  = combine(nets(i),nets(j));
                            if i > j 
                                nets(i) = [];
                                nets(j) = [];
                            else
                                nets(j) = [];
                                nets(i) = [];                      
                            end
                            nets = [nets new_net];
                            change = true;
                            break
                        end
                    end
                end
                if change
                    break
                end
            end
        end
        %%
        % comprobamos el el fin del bucle
        iter = iter +1;
        if iter > maxiter 
           fin = true;
        elseif  length(nets) == 1 
            if length(nets.vertexs) >= 300
                fin = true;
            end
        end
    end


    net = nets;
end
