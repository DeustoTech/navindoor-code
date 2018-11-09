function osegment = resampling(isegment,varargin)
%RESAMPLING Summary of this function goes here
%   Detailed explanation goes here

    p = inputParser;
    addRequired(p,'isegment');
    addOptional(p,'dx',0.5);
    
    parse(p,isegment,varargin{:})
    
    dx = p.Results.dx;
    
    %%
    new_cumsum = 0:dx:isegment.cumsum(end);
    
    new_x = interp1(isegment.cumsum,[isegment.points.x],new_cumsum);
    new_y = interp1(isegment.cumsum,[isegment.points.y],new_cumsum);
    new_z = interp1(isegment.cumsum,[isegment.points.z],new_cumsum);
    
    points = mat2points([new_x' new_y' new_z']);
    
    osegment = segment(points);
    
    
end

