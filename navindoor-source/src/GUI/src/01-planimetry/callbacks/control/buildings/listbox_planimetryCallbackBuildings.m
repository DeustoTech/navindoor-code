function listbox_planimetryCallbackBuildings(object,event,h)
%LISTBOX_PLANIMETRYCALLBACKBUILDINGS Summary of this function goes here
%   Detailed explanation goes here

    
    listbox_buildings = findobj_figure(h.iur_figure,'Planimetry','Buildings','listbox');
    index_buildings = listbox_buildings.Value;
    
    delete([h.planimetry_layer.building_layers.graphs_border_buildings])
    PlotBuildings(h.planimetry_layer.building_layers, h.DirectAccess.Planimetry.Axes.Children,index_buildings);

    update_planimetry_layer(h,'DeleteGraphs',true,'ReplotPng',true)
end

