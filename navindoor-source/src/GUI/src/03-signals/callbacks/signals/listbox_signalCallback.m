function listbox_signalCallback(object,event,h)
%LISTBOX_SIGNALCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    update_signal_layer(h);

    persistent chk
    if isempty(chk)
          chk = 1;
          pause(0.25); %Add a delay to distinguish single click from a double click
          if chk == 1
              chk = [];
          end
    else
        chk = [];
        listbox_strajs = findobj_figure(h.iur_figure,'Signal Generation','Supertraj','listbox');
        index_strajs = listbox_strajs.Value;
        
        signal = h.trajectory_layer(index_strajs).signal_layer(object.Value).signal;
        if ~isempty(signal)
            TableOfObjects(signal);
        end
    end
    

    
end

