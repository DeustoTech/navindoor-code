function export_callback_navindoor_OSM(object,event,h)
%EXPORT_CALLBACK_NAVINDOOR_OSM Summary of this function goes here
%   Detailed explanation goes here
    url  = char(h.browser.getCurrentLocation);
    
    randnumber = num2str(floor(1000*rand),'%.4d');
    datenumber = replace(replace(num2str(clock),' ',''),'.','');
    
    path = [datenumber,'-',randnumber,'.osm'];
    
    DownloadOsm(url,path)
    h.path = path;
end

