function result = select(walls,r,varargin)

    p = inputParser;
    addRequired(p,'walls')
    addRequired(p,'r')
    addOptional(p,'precision',3.0)
    
    parse(p,walls,r,varargin{:})
    
    precision = p.Results.precision;
    %%
    
    distances = arrayfun(@(iwall) distw(iwall,r),walls);
   [min_value, index_min] = min([distances.distance]);

    if precision >= min_value
       result.index = index_min;
       result.r     = distances(index_min).r;
       walls(index_min).select = ~walls(index_min).select;
    else 
        result = [];
    end
   
end
