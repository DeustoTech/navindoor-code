function ListBox_Navigation_Levels(object,event,h)
%LISTBOX_NAVEGATION_LEVELS Summary of this function goes here
%   Detailed explanation goes here

    imap            = h.planimetry_layer.map;
    Parent          = h.DirectAccess.Trajectory.Axes;
    
    index_level     =  h.DirectAccess.Trajectory.Navigation.Levels.Value;
    index_buildings =  h.DirectAccess.Trajectory.Navigation.Buildings.Value;    
    Indexs = [index_buildings,index_level];

    delete(h.graphs_trajectory_layer.planimetry);
    delete(h.graphs_trajectory_layer.trajectory);
    if ~isempty(imap.buildings(index_buildings).levels)
        h.graphs_trajectory_layer.planimetry = plot(imap,'Indexs',Indexs,'Parent',Parent);
    else
        h.graphs_trajectory_layer.planimetry = plot(imap,'Parent',Parent);
    end
    
    update_trajectory_layer(h)

end

