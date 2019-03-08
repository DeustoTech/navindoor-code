function h = NavindoorOsm()
%NAVINDOOR-OSM Summary of this function goes here
%   Detailed explanation goes here

h = NavindoorOsmHandle;

h.figure  =  figure('Name','OpenStreetMap-Navindoor',  ...
                              'NumberTitle','off',       ...
                              'Units', 'normalize',      ...
                              'Position', [0.1 0.1 0.8 0.8],     ...
                              'MenuBar','none');
  
                          
%%
set(h.figure,'defaultuicontrolFontSize',14)
%%                          
jObject = com.mathworks.mlwidgets.html.HTMLBrowserPanel;

[browser,container] = javacomponent(jObject,[],h.figure);
set(container,'Units','norm','Pos',[0.005 0.005 0.875 0.99])
browser.setCurrentLocation('https://www.openstreetmap.org/#map=18/43.27085/-2.93846')
%%
uicontrol('Parent',h.figure,'style','pushbutton','String','Export','Tag','Export','Unit','norm','Pos',[0.9 0.8 0.075 0.075],'Callback',{@export_callback_navindoor_OSM,h});     
uicontrol('Parent',h.figure,'style','pushbutton','String','Cancel','Tag','Cancel','Unit','norm','Pos',[0.9 0.7 0.075 0.075],'Callback',{@delete_callback_navindoor_OSM,h});

h.browser = browser;

end

