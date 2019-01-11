function listboxSupertrajProcessingCallback(object,event,h)
%LISTBOXSUPERTRAJPROCESSINGCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    
    listbox_straj = findobj_figure(h.iur_figure,'Signal Processing','Supertraj','listbox');
    listbox_estimators = findobj_figure(h.iur_figure,'Signal Processing','Estimators','listbox');

    
    persistent index_straj
    if isempty(index_straj)
        index_straj  = listbox_straj.Value;
    else
        if index_straj ~= listbox_straj.Value
            index_straj = listbox_straj.Value;
            listbox_estimators.Value = 1;
        end
    end


        
    update_processing_layer(h)
    

    
end

