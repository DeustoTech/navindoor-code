function select = questiondlgindex(number)
    % Funcion para seleccionar un indice dentro de un lista 
    % 
    h = questiondlgindexclass;
    h.figure = figure('Unit','norm','Position',[0.425 0.4 0.05 0.2]);
    h.figure.MenuBar = 'none';
    h.figure.NumberTitle = 'off';
    h.figure.Resize= 'off';
    h.select = [];
    
    String = num2str((1:number)');
    h.btnlist   = uicontrol('style','listbox','Parent',h.figure,'String',String,'Unit','norm','Position',[0.1 0.2 0.8 0.7]); 
    
    h.btnok     = uicontrol('style','pushbutton','Parent',h.figure,'String','OK','Unit','norm','Position',[0.3 0.05 0.4 0.1],'Callback',{@callbackok,h});

    waitfor(h.figure)
    
    select = h.select;
end

function callbackok(obj,event,h)
    h.select = h.btnlist.Value;
    delete(h.figure)
end