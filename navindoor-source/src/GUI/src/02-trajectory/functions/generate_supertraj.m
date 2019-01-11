function generate_supertraj(h)


    % find object listbox in supertraj panel
    listbox = findobj_figure(h.iur_figure,'tabgroup','Trajectory','Supertraj','listbox');
    index_straj = listbox.Value;

    %% Si se agrega una nueva  straj, es necesario eliminar las señales previas 
    len =length(h.trajectory_layer(index_straj).signal_layer);
    for index = 1:len
        h.trajectory_layer(index_straj).signal_layer(index).signal = [];
    end    
    
    
    lenvertex = length([h.trajectory_layer(index_straj).supertraj.trajs.nodes]);
    if length(h.trajectory_layer(index_straj).vertexs) == lenvertex
       return 
    end
    
    ibuild = h.planimetry_layer(1).build;
   
    if ~isempty(h.trajectory_layer(index_straj).vertexs)
        h.trajectory_layer(index_straj).supertraj = supertraj(h.trajectory_layer(index_straj).vertexs,h.trajectory_layer(index_straj).connections,'build',ibuild,'hold_nodes',true);
    else 
        h.trajectory_layer(index_straj).supertraj = supertraj;
    end
    % Recuperamos las propiedades perdidas por volver a generar la supertraj
    h.trajectory_layer(index_straj).supertraj.label = h.trajectory_layer(index_straj).label;

    
end

