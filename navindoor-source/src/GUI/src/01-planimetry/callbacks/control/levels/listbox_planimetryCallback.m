function listbox_planimetryCallback(~,~,h)
%LISTBOX_PLANIMETRYCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    
    update_planimetry_layer(h,'DeleteGraphs',true,'ReplotPng',true)
end

