function  navindoor
h.data = [];

h.figure = figure(   'Name','Welcome to navindoor',                        ...
                     'NumberTitle','off',                       ...
                     'Units', 'normalize',                      ...
                     'Position', [0.4 0.4 0.15 0.15   ],       ...
                     'Visible','on',                           ...
                     'MenuBar','none');
wd = 0.2;
ht = 0.2;
new_btn = uicontrol('style','pushbutton','String','New','Unit','norm','Position', [0.2 0.6 wd ht],'Parent',h.figure,'Callback',{@new_callback,h});

open_btn = uicontrol('style','pushbutton','String','Open','Unit','norm','Position', [0.2 0.2 wd ht],'Parent',h.figure,'Callback',{@new_callback,h});

end
function new_callback(object,event,h)
    delete(h.figure)
    NavindoorOsm
end

function open_callback(object,event,h)
    object
end