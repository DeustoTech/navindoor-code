function axes_planimetry_callback(object,event,h)
    %
    %%
    % Deberemos si el botton move esta pulsado 
    % si es asi, quiere decir que el usuario quiere mover la imagen, por tanto
    % salimos de programa
    %%% btn_move_PNG = findobj_figure(h.iur_figure,'Planimetry','PNG File','btnmove');
    btn_move_PNG = h.iur_figure.Children(1).Children(1).Children(2).Children(2).Children(1);
    if btn_move_PNG.Value
       return
    end
    %% 
    % Recogemos el planimetry_layer correspondiente segun el nivel que este 
    % selecionado en el momento que hacemos click
    %%% list_box   = findobj_figure(h.iur_figure,'Planimetry','Levels','listbox');
    list_box   = h.iur_figure.Children(1).Children(1).Children(2).Children(3).Children(6);
    index_level = list_box.Value;
    vb = h.planimetry_layer(index_level);
    %
    %% 
    % Creamos un nodo segun el x y z clickado
    C = object.CurrentPoint;
    height = h.planimetry_layer(index_level).height;
    cnode = node([C(1,1),C(1,2) height]);
    % Definimos la presion con la que consireamos que un objecto ha sido selecionado o no;
    precision = (0.05 *  sqrt( (object.XLim(2)-object.XLim(1))^2 + (object.YLim(2)-object.YLim(1))^2 ));
    %
    %
    %% 
    % Mirarmos que opcion y que modo esta selecionado 
    option = h.javacomponets.planimetry_layer.btngrp_option.getSelection.getActionCommand();
    option = [option.toCharArray]';
    mode   = h.javacomponets.planimetry_layer.btngrp_mode.getSelection.getActionCommand();
    mode = [mode.toCharArray]';
    %
    %%
    % Segun el modo y el tipo de accion redireccionamos el codigo a las distintas opciones 
    switch mode
        case 'nodes'
            mode_nodes(vb,cnode,option,precision)
        case 'walls'
            mode_walls(vb,cnode,option,precision,index_level)
        case 'doors'
            mode_doors(vb,cnode,option,precision,index_level)
        case 'elevators'
            mode_elevators(vb,cnode,option,precision,index_level)
        case 'stairs'
            mode_stairs(vb,cnode,option,precision,index_level)
        case 'connections'
            vb = h.planimetry_layer(1);
            mode_connections(vb,cnode,option,precision,index_level)
        case 'beacons'
            mode_beacons(vb,cnode,option,precision,index_level)

    end
    %%
    % Luego de realizar los cambios en planimetry_layer
    % actualizamos la vista para ver los cambios 
    update_planimetry_layer(h,'auto_zoom',false,'replot',true,'onlyclickaxes',true,'mode',mode,'option',option);

end

