function DownloadOsm(url,path,varargin)
%DOWNLOADOSM 
    p = inputParser;
    
    addRequired(p,'url')
    addRequired(p,'path')

    addOptional(p,'width',425)
    addOptional(p,'height',425)

    parse(p,url,path,varargin{:})
    
    width  = p.Results.width;
    height = p.Results.height;
    
    %%
    
    urlsplit = strsplit(url,'/');
 
    lon  = str2num(urlsplit{end});
    lat  = str2num(urlsplit{end-1});
    zoom = str2num(replace(urlsplit{end-2},'#map=',''));

    bbox = LonLat2bbox(lat,lon,zoom,'height',height,'width',width);

    lon_s = num2str(bbox.lon_s);
    lon_e = num2str(bbox.lon_e);
    lat_s = num2str(bbox.lat_s);
    lat_e = num2str(bbox.lat_e);
    
    urlGET = ['https://api.openstreetmap.org/api/0.6/map?bbox=',lon_s,',',lat_e,',',lon_e,',',lat_s];
    websave(path,urlGET)
end

