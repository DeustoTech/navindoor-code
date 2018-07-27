function save_buildCallback(object,event,h)
%SAVE_BUILDCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    [file,path] = uiputfile('*.mat','Save Workspace As');
    if ~isnumeric(path)
        generate_build(h.planimetry_layer);
        building = h.planimetry_layer.build;
        save(strcat(path,file),'building')
    end

end

