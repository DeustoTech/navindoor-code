function save_levelCallback(object,event,h)
%SAVE_BUILDCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    [file,path] = uiputfile('*.mat','Save Workspace As');
    if ~isnumeric(path)
        h.planimetry_layer(1).building = generate_build(h.planimetry_layer);
        building = h.planimetry_layer(1).building;
        
        listbox_level = findobj_figure(h.iur_figure,'Planimetry','Levels','listbox');
        index_level = listbox_level.Value;
        ilevel = building.levels(index_level);
        
        save(strcat(path,file),'ilevel')
    end

end

