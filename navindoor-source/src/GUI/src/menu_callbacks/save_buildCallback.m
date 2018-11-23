function save_buildCallback(object,event,h)
%SAVE_BUILDCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    [file,path] = uiputfile('*.mat','Save Workspace As');
    if ~isnumeric(path)
        h.planimetry_layer(1).building = generate_build(h.planimetry_layer);
        building = h.planimetry_layer(1).building;
        save(strcat(path,file),'building')
    end

end

