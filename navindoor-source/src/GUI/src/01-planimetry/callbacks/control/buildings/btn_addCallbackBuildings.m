function btn_addCallbackBuildings(object,event,h)

    msgbox('Crea el contorno del edificio!','Mensaje','modal')
%BTN_ADDCALLBACKBUILDINGS Summary of this function goes here
    ax   = findobj_figure(h.iur_figure,'Planimetry','Graphs','axes');
%   Detailed explanation goes here
    points = drawpolygon(ax);
    
    newbuilding = building;
    
    newbuilding.border = points;
    
    len = length(h.planimetry_layer);
    
    h.planimetry_layer(len+1) = planimetry_layer;    
    h.planimetry_layer(len+1).border.position = points.Position;
    h.planimetry_layer(len+1).border.XLim = [min(points.Position(:,1)) max(points.Position(:,1))];
    h.planimetry_layer(len+1).border.YLim = [min(points.Position(:,2)) max(points.Position(:,2))];
    
    delete(points)
    update_planimetry_layer(h,'NoPlot',true)
end

