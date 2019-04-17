function ListBox_Navigation_Buildings(object,event,h)
%LISTBOX_NAVEGATION_BUILDINGS Summary of this function goes here
%   Detailed explanation goes here
    index_buildings = object.Value;
    index_level     = 1;
    imap            = h.planimetry_layer.map;
    Parent          = h.DirectAccess.Trajectory.Axes;
    
    levels = imap.buildings(index_buildings).levels;
    
    listbox_levels          = h.DirectAccess.Trajectory.Navigation.Levels;
    listbox_levels.String   = num2str((0:(length(levels)-1))');
    listbox_levels.Value   = index_level;
    
    Indexs = [index_buildings,index_level];
    
    delete(h.graphs_trajectory_layer.planimetry);
    if ~isempty(levels)
        h.graphs_trajectory_layer.planimetry = plot(imap,'Indexs',Indexs,'Parent',Parent);
    else
        h.graphs_trajectory_layer.planimetry = plot(imap,'Parent',Parent);
    end
    
    update_trajectory_layer(h)
end

