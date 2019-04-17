function btn_addCallbackBuildings(object,event,h)

    msgbox('Crea el contorno del edificio!','Mensaje','modal')
    ax   = findobj_figure(h.iur_figure,'Planimetry','Graphs','axes');
%   Detailed explanation goes here
    points = drawpolygon(ax);
            
    len = length(h.planimetry_layer.building_layers);
    
    h.planimetry_layer.building_layers(len+1) = building_layer;  
    h.planimetry_layer.building_layers(len+1).border.polyshape = polyshape(points.Position);
    h.planimetry_layer.building_layers(len+1).border.position = points.Position;
    h.planimetry_layer.building_layers(len+1).border.XLim = [min(points.Position(:,1)) max(points.Position(:,1))];
    h.planimetry_layer.building_layers(len+1).border.YLim = [min(points.Position(:,2)) max(points.Position(:,2))];
    
    
    %%
    height          = 0;
    border_position = h.planimetry_layer.building_layers(len+1).border.position;
    number_nodes    = length(border_position(:,1));
    %
    nodes = arrayfun(@(index)node([border_position(index,:) height]),1:number_nodes);
    
    index_nodes = [mod(0:(number_nodes-1),number_nodes)+1;mod(1:number_nodes,number_nodes)+1];
    walls =  arrayfun(@(index)wall([nodes(index_nodes(1,index)),nodes(index_nodes(2,index))]),1:number_nodes);
    
    h.planimetry_layer.building_layers(len+1).border.walls = walls;
        
    delete([h.planimetry_layer.building_layers.graphs_border_buildings])
    delete(points)
    index_building = h.DirectAccess.Planimetry.listbox_building.Value;
    
    PlotBuildings(h.planimetry_layer.building_layers, h.DirectAccess.Planimetry.Axes.Children,index_building);

    update_planimetry_layer(h,'NoPlot',true,'DeleteGraphs',true)

end

