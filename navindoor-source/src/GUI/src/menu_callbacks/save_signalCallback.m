function  save_signalCallback(object,event,h)
%SAVE_SIGNALCALLBACK Summary of this function goes here
%   Detailed explanation goes here

    
    
    [file,path] = uiputfile('*.mat','Save Workspace As');
    if ~isnumeric(path)
        listbox_signals = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Signals','listbox');
        index_signals = listbox_signals.Value;
        listbox_straj = findobj_figure(h.iur_figure,'tabgroup','Signal Generation','Supertraj','listbox');
        index_straj = listbox_straj.Value;
        signal = h.trajectory_layer(index_straj).signal_layer(index_signals).signal;
        if isempty(signal)
            errordlg('You don''t have a signal')
           return  
        end
        save(strcat(path,file),'signal')
    end

    
end

