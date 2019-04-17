function export_callback_navindoor_OSM(object,event,h)
%EXPORT_CALLBACK_NAVINDOOR_OSM Summary of this function goes here
%   Detailed explanation goes here
    url  = char(h.browser.getCurrentLocation);
    
    
    file = 'StartNavindoor.m';
    pathfile = replace(which(file),file,'');
    
    pathfile = fullfile(pathfile,'data','osm-maps');
    
    randnumber = num2str(floor(1000*rand),'%.4d');
    datenumber = replace(replace(num2str(clock),' ',''),'.','');
    
    [file,path] = uiputfile(fullfile(pathfile,'*.osm'),'Save Workspace As');

    %path = [datenumber,'-',randnumber,'.osm'];
    path = fullfile(path,file);
    if path == 0
       return 
    end
    browser = h.browser.getSize.get;
    

    DownloadOsm(url,path,'width',browser.Width,'height',browser.Height);
    h.path = path;
    
    delete(h.figure)
    
    navindoor_init(path)
end

