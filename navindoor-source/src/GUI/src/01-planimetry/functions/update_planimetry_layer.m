function update_planimetry_layer(h,varargin)
% Programa para actualizar la capa de palanimetria en la GUI. Recibe la
% estructura principal de la GUI

% Control of parameters 
    p = inputParser;
    addRequired(p,'h')
    addOptional(p,'auto_zoom',false)
    addOptional(p,'onlyclickaxes',false)
    addOptional(p,'mode',[])
    addOptional(p,'option',[])
    addOptional(p,'DeleteGraphs',false)
    addOptional(p,'NoPlot',false)
    addOptional(p,'ReplotPng',false)

    

    parse(p,h,varargin{:})

    onlyclickaxes   = p.Results.onlyclickaxes;
    mode            = p.Results.mode;
    option          = p.Results.option;
    DeleteGraphs    = p.Results.DeleteGraphs;
    NoPlot          = p.Results.NoPlot;
    ReplotPng       = p.Results.ReplotPng;
% 
    tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
    %% Building Panel 
    buildings_panel = findobj(tab_planimetry,'Title','Buildings');
    % 
    boxbuildings    = findobj_figure(buildings_panel,'listbox');
    index_buildings = boxbuildings.Value;
    %% Levels Panel 
    %
    level_panel = findobj(tab_planimetry,'Title','Levels');
    % 
    boxlevels   = findobj(level_panel,'Style','listbox');

    %% Si solo se ha hecho click, solo hay que actualizar el grafico
    if onlyclickaxes
        index_level = boxlevels.Value;
    else
        % Update buildings listbox 
        number_of_buildings = length(h.planimetry_layer.building_layers);
        
        if index_buildings > number_of_buildings
            boxlevels.Value  = number_of_buildings;
            index_buildings  = boxlevels.Value;
        end
        boxbuildings.String = num2str((1:number_of_buildings)');
     
        minus               = findobj_figure(buildings_panel,'minus');    
        view                = findobj_figure(buildings_panel,'view');
        add_level           = findobj_figure(level_panel,'add');
        listbox_buildings   = findobj_figure(buildings_panel,'listbox');
        ListOfObjects = {minus,view,add_level,listbox_buildings};
        % Activar o desactivar minus y view building 3d segun exista a no 
        % algun edificio con el que trabajar
        if number_of_buildings ~= 0
            EnableOnOff(ListOfObjects,'on')
        else
            EnableOnOff(ListOfObjects,'off')
        end
            
        %%
        % Si existe algun edificio, 
        if number_of_buildings ~= 0
           number_of_levels = length(h.planimetry_layer.building_layers(index_buildings).level_layer); 
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          minus             = findobj_figure(level_panel,'minus');
          height            = findobj_figure(level_panel,'Height');
          listbox_level     = findobj_figure(level_panel,'listbox');
          pngfile_edit      = findobj_figure(tab_planimetry,'PNG File','path');
          pngfile_load      = findobj_figure(tab_planimetry,'PNG File','btnload');

          listOfObjects     = {minus,height,listbox_level,pngfile_edit,pngfile_load};
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          if number_of_levels ~= 0
                   index_level = boxlevels.Value;

                   if index_level > number_of_levels
                        boxlevels.Value  = number_of_levels;
                        index_level = boxlevels.Value;
                   end
                   boxlevels.String = num2str((0:number_of_levels-1)');

                    %%
                    EnableOnOff(listOfObjects,'on')
                    height.String = num2str(h.planimetry_layer.building_layers(index_buildings).level_layer(index_level).height);
                    if ~isempty(h.planimetry_layer.building_layers(index_buildings).level_layer(index_level).picture_level)
                        pngfile_edit.String = h.planimetry_layer.building_layers(index_buildings).level_layer(index_level).picture_level.pngfile;
                    end
 
           % Si no hay ningun nivel en el edificio entonces ...
           else
                boxlevels.String  = [];
                minus.Enable = 'off';
                height.Enable = 'off';
                listbox_level.Enable = 'off';         
           end
        end
        

                
    end
    
    %% Graph Panel
    if NoPlot
       return 
    end
    if DeleteGraphs
        for iBuilding = h.planimetry_layer.building_layers
            for iLevelLayer = iBuilding.level_layer
                
                delete(iLevelLayer.layer_graphs)
                if ~isempty(iLevelLayer.picture_level)
                    delete(iLevelLayer.picture_level.picture.Image)
                end
            end
        end
        
    end
    axes_planimetry = h.DirectAccess.Planimetry.Axes.Children; 
    
    if exist('index_level','var')
        plot(h.planimetry_layer,index_buildings,index_level,axes_planimetry,'mode',mode,'option',option,'ReplotPng',ReplotPng);
    end
end



