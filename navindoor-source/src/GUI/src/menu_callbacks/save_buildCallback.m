function save_buildCallback(object,event,h)
%SAVE_BUILDCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    [file,path] = uiputfile('*.mat','Save Workspace As');
    if ~isnumeric(path)
       GenerateMap(h.planimetry_layer);
        index_building = h.DirectAccess.Planimetry.listbox_building.Value;
        building =  h.planimetry_layer.map.buildings(index_building);
        save(strcat(path,file),'building')
    end

end

