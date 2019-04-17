function btn_insert_planimetry(object,event,h)
% Callbck cuando se clicka en el boton de insertar en la pestana de
% planimetria
    
    % Elegimo el puntero del mosue correcto 
    h.iur_figure.Pointer = 'arrow';
    h.zoom_iurfigure.Enable = 'off';
    h.pan_iurfigure.Enable = 'off' ;
    % Selectionamos los botenes insert 
    h.javacomponets.planimetry_layer.btn_insert.setSelected(1)
    h.javacomponets.trajectory_layer.btn_insert.setSelected(1)
    % 
   listbox_building = h.DirectAccess.Planimetry.listbox_building;
   listbox_levels   = h.DirectAccess.Planimetry.listbox_levels;
   
   %%
   if ~isempty(h.planimetry_layer.building_layers)
      if ~isempty(h.planimetry_layer.building_layers(listbox_building.Value).level_layer)
        empty_data = false;
      else  
         empty_data = true;
      end
   else
      empty_data = true;
   end
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
   %%
    unselect(h.planimetry_layer.building_layers(listbox_building.Value).level_layer(listbox_levels.Value).nodes)
   unselect(h.planimetry_layer.building_layers(listbox_building.Value).level_layer(listbox_levels.Value).doors)
   unselect(h.planimetry_layer.building_layers(listbox_building.Value).level_layer(listbox_levels.Value).walls)
   unselect(h.planimetry_layer.building_layers(listbox_building.Value).level_layer(listbox_levels.Value).stairs)
   unselect(h.planimetry_layer.building_layers(listbox_building.Value).level_layer(listbox_levels.Value).elevators)
   unselect(h.planimetry_layer.building_layers(listbox_building.Value).level_layer(listbox_levels.Value).beacons)
   
   if strcmp(h.DirectAccess.Planimetry.tab.Parent.SelectedTab.Title,'Planimetry')
        update_planimetry_layer(h,'replot',true)
   end

end

