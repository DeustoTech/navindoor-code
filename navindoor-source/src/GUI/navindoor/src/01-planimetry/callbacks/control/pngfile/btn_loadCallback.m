function btn_loadCallback(object,event,h)
%BTN_LOADCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    % selection of level 
    tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
    control_panel  = findobj(h.iur_figure,'Title','Levels');
    list_box   = findobj(control_panel,'Style','listbox');

    index_level = list_box.Value;
    vb  = h.planimetry_layer(index_level);
    
    [namepng,path] = uigetfile('*.png','Select the MATLAB code file');
    if ~isa(path,'double')
         file = {strcat(path,namepng)};
         vb.pngfile = file{1};
         % creamos la variables imagemap
         % a partir de la direccion cargada
        [vb.image_map,~] = imread(file{1});
         % activamos el chexbox para que se pueda ver 
         % la imagen cargada
         vb.showfigure = 1;
         % por defecto los rangos de la imagen
         % es la misma que los rangos del nivel actual
         vb.XLim_image = vb.XLim;
         vb.YLim_image = vb.YLim;
    end
    
    
    
    % refrescamos la figure
    update_planimetry_layer(h)
    
    
end

