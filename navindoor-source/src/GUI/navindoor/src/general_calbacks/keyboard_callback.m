function keyboard_callback(event,object,h)

    %KEYBOARD_CALLBACK Summary of this function goes here
    %   Detailed explanation goes here
    listbox_level = findobj_figure(h.iur_figure,'Planimetry','Control','Levels','listbox');
    index_level = listbox_level.Value;
    %%
    if ~isempty(h.planimetry_layer(index_level).nodes)
        h.planimetry_layer(index_level).nodes = DeleteSelect(h.planimetry_layer(index_level).nodes);
        % removemos todos los objectos walls que necesiten el nodo eliminado
        boolean_index = arrayfun(@(iwall) ~isvalid(iwall.nodes(1))||~isvalid(iwall.nodes(2)),h.planimetry_layer(index_level).walls);
        if ~isempty(h.planimetry_layer(index_level).walls)
            numero_eliminados = 0;
            for index = 1:length(h.planimetry_layer(index_level).walls)
                if boolean_index(index)
                    if ~isempty(h.planimetry_layer(index_level).walls(index-numero_eliminados).doors)
                        delete(h.planimetry_layer(index_level).walls(index-numero_eliminados).doors)
                    end
                    h.planimetry_layer(index_level).walls(index-numero_eliminados) = [];
                    numero_eliminados = numero_eliminados + 1;
                end
            end
        end
    end
    %%
    if ~isempty(h.planimetry_layer(index_level).elevators)
        h.planimetry_layer(index_level).elevators = DeleteSelect(h.planimetry_layer(index_level).elevators);
    end
    %%
    if ~isempty(h.planimetry_layer(index_level).stairs)
        h.planimetry_layer(index_level).stairs = DeleteSelect(h.planimetry_layer(index_level).stairs);
    end
    %%
    if ~isempty(h.planimetry_layer(index_level).beacons)
        h.planimetry_layer(index_level).beacons = DeleteSelect(h.planimetry_layer(index_level).beacons);
    end
    %%
    if ~isempty(h.planimetry_layer(index_level).doors)
        h.planimetry_layer(index_level).doors = DeleteSelect(h.planimetry_layer(index_level).doors);
    end
    %%
    if ~isempty(h.planimetry_layer(index_level).walls)
        h.planimetry_layer(index_level).walls = DeleteSelect(h.planimetry_layer(index_level).walls);
    end
    %% 
    % Eliminamos los objectos doors que puedan estar invalidos 
    
    boolean_index = arrayfun(@(idoor) ~isvalid(idoor),h.planimetry_layer(index_level).doors);
    numero_eliminados = 0;
    for index = 1:length(h.planimetry_layer(index_level).doors)
        if boolean_index(index)
            h.planimetry_layer(index_level).doors(index-numero_eliminados) = [];
            numero_eliminados = numero_eliminados + 1;
        end
    end
    % Renderizamos la vista 
    update_planimetry_layer(h,'replot',true)

end

