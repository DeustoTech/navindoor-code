%% ID: 20180614-gui-hightbox
% =================================
% Title____:    Añadimos la funcionalidad de agregar altura para cada planta creada, en el interfaz grafico
% Date_____:    04/06/2018
% Reason___:    En el momento del cambio, la interfaz grafica asignaba la propiedad hight_levels del objeto
%               build, por defecto. Antes esta hight_levels = [0 5 10 15 ...], Ahora con el cambio podemos y 
%               debemos asignar el valor de la altura para cada nivel.

function generate_build(obj)

    for index=1:length(obj)
        unselect(obj(index))
    end
    
    obj(1).elevators = [obj(1).elevators obj(1).select_elevators];
    obj(1).stairs = [obj(1).stairs obj(1).select_stairs];

    obj(1).connections = [obj(1).connections obj(1).select_connections];

    obj(1).build = build;
    len = length(obj);
    obj(1).build.len = len;
    
    %% ID: 20180614-gui-hightbox
    % eliminamos harcodeo
    %
    %intlevel = 5;
    %height_levels = 0:intlevel:intlevel*(len - 1);
    %obj(1).build.height_levels = height_levels;
    %% 
    
    
    obj(1).build.levels(1:len) = zeros(1,len,'level');
    obj(1).build.height_levels = zeros(1,len);
    for index=1:len
        obj(1).build.levels(index) = level(obj(index).nodes,obj(index).walls,obj(index).doors,obj(index).beacons,[obj(index).XLim(2),obj(index).YLim(2)]);
        
        %% ID: 20180614-gui-hightbox:
        % Agregamos los distintos valores de las alturas 
        obj(1).build.levels(index).high = obj(index).hieght;
        obj(1).build.height_levels(index) = obj(index).hieght;
        %% ID: 20180614-end --------
        
        for ielevators = obj(1).elevators 
            if ielevators.level == index - 1
               obj(1).build.levels(index).elevators = [ obj(1).build.levels(index).elevators ielevators];
            end
        end
        for istairs = obj(1).stairs 
            if istairs.level == index - 1
               obj(1).build.levels(index).stairs = [ obj(1).build.levels(index).stairs istairs];
            end
        end
        obj(1).build.levels(index).n = index - 1;
    end
    obj(1).build.connections = obj(1).connections;
    
    %% 
    



