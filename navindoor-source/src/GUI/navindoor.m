function  navindoor
% Programa principal navindoor. Se decide si abrir un osm o se redirige al
% programa que exporta los ficheros .osm
h.data = [];

h.figure = figure(   'Name','Welcome to navindoor',                        ...
                     'NumberTitle','off',                       ...
                     'Units', 'normalize',                      ...
                     'Position', [0.45 0.45 0.125 0.125   ],       ...
                     'Visible','on',                           ...
                     'MenuBar','none');
wd = 0.4;
ht = 0.3;
new_btn = uicontrol('style','pushbutton','String','New OSM','Unit','norm','Position', [0.3 0.6 wd ht],'Parent',h.figure,'Callback',{@new_callback,h});

open_btn = uicontrol('style','pushbutton','String','Open OSM','Unit','norm','Position', [0.3 0.2 wd ht],'Parent',h.figure,'Callback',{@open_callback,h});

end
function new_callback(object,event,h)
    delete(h.figure)
    NavindoorOsm;
end

function open_callback(object,event,h)
	path = which('StartNavindoor');
    path = fullfile(replace(path,'StartNavindoor.m',''),'data','osm-maps');
    

    [namemat,path] = uigetfile(fullfile(path,'*.osm'),'Select the OSM file');
    if path ~= 0
        delete(h.figure)
        navindoor_init(fullfile(path,namemat))
    end
     
end