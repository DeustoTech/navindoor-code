function listboxSupertrajSignalsCallback(object,event,h)
%LISTBOXSUPERTRAJSIGNALSCALLBACK Summary of this function goes here
%   Detailed explanation goes here
    listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');
    listbox_signals.Value = 1;
    
    persistent chk
    if isempty(chk)
          chk = 1;
          pause(0.25); %Add a delay to distinguish single click from a double click
          if chk == 1
              chk = [];
          end
    else
        chk = [];

    end
    
    update_signal_layer(h)

end

