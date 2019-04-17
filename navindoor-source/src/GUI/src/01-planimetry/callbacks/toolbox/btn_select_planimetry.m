function btn_select_planimetry(object,event,h)
% Callbck cuando se clicka en el boton de select en la pestana de
% planimetria

    h.iur_figure.Pointer = 'circle';
    h.zoom_iurfigure.Enable = 'off';
    h.pan_iurfigure.Enable = 'off' ;
    
   h.javacomponets.planimetry_layer.btn_select.setSelected(1)
   
   listbox_building = h.DirectAccess.Planimetry.listbox_building;
   listbox_levels   = h.DirectAccess.Planimetry.listbox_levels;
   
   %% Comprobamos que exista alguno edificio o nivel donde poder selecionar elementos 
   if ~isempty(h.planimetry_layer.building_layers)
      if ~isempty(h.planimetry_layer.building_layers(listbox_building.Value).level_layer)
        empty_data = false;
      else  
         empty_data = true;
      end
   else
      empty_data = true;
   end
   %%
   % Si es asi marcamos el boton insert y configuramos el puntero para que
   % sea coerente
   if empty_data
        h.iur_figure.Pointer = 'arrow';
        h.zoom_iurfigure.Enable = 'off';
        h.pan_iurfigure.Enable = 'off' ;
        % Selectionamos los botenes insert 
        h.javacomponets.planimetry_layer.btn_insert.setSelected(1)
        h.javacomponets.trajectory_layer.btn_insert.setSelected(1)
        return
   end
   
   % En caso contrario seleccionamos el nivel 
   
   level_layer = h.planimetry_layer.building_layers(listbox_building.Value).level_layer(listbox_levels.Value);

   % Deselecionamos todos los elementos
   unselect(level_layer.nodes)
   unselect(level_layer.doors)
   unselect(level_layer.walls)
   unselect(level_layer.stairs)
   unselect(level_layer.elevators)
   unselect(level_layer.beacons)
    % Acualizamos la vista
   update_planimetry_layer(h,'replot',true)
end

