function bbox = LonLat2bbox(lat,lon,zoom,varargin)

    p = inputParser;
    
    addRequired(p,'lat')
    addRequired(p,'lon')
    addRequired(p,'zoom')

    addOptional(p,'width',425)
    addOptional(p,'height',425)

    parse(p,lat,lon,zoom,varargin{:})
    
    width  = p.Results.width;
    height = p.Results.height;
    
    tile_size = 256;

	[xtile,ytile] = getTileNumber(lat,lon,zoom);

	xtile_s = (xtile * tile_size - width/2) / tile_size;
	ytile_s = (ytile * tile_size - height/2) / tile_size;
	xtile_e = (xtile * tile_size + width/2) / tile_size;
	ytile_e = (ytile * tile_size + height/2) / tile_size;

	[bbox.lon_s, bbox.lat_s] = getLonLat(xtile_s, ytile_s, zoom);
	[bbox.lon_e, bbox.lat_e] = getLonLat(xtile_e, ytile_e, zoom);

end

function [xtile,ytile] = getTileNumber(lat,lon,zoom)
    xtile = floor( (lon+180)/360 * 2^zoom ) ;
    ytile = floor( (1 - log(tan(deg2rad(lat)) + sec(deg2rad(lat)))/pi)/2 * 2^zoom ) ;
end

function [lon_deg,lat_deg] = getLonLat(xtile, ytile, zoom)
	n = 2^zoom;
	lon_deg = xtile/n * 360.0 - 180.0;
	lat_deg = rad2deg(atan(sinh(pi * (1 - 2 * ytile / n))));
end

