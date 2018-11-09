function init_signal_processing(object,event,h)
%INIT_SIGNAL_PROCESSING Summary of this function goes here
%   Detailed explanation goes here

    %%

    %%
    listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Signal Processing','Supertraj','listbox');

    listbox_straj.String =  {h.trajectory_layer.label};
     
    %% Signals Aviable 

    for itrajlayer = h.trajectory_layer
        signals = {};
        index = 0;
        for isignalayer = itrajlayer.signal_layer
           if ~isempty(isignalayer.signal)
               index  = index + 1;
               signals{index}= isignalayer.signal;
           end
        end
        itrajlayer.aviable_signals = signals;
    end
    
    
    %%
    
    update_processing_layer(h,'layer',true)
end

