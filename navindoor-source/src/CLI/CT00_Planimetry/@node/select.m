function result = select(nodes,r,varargin)
%SELECT change select property of list of nodes 
   %%
   p = inputParser;

   addRequired(p,'nodes')
   addRequired(p,'r')
   addOptional(p,'precision',2.0)
   
   parse(p,nodes,r,varargin{:})
   
   precision = p.Results.precision;
   
   distances = arrayfun(@(inode) norm(inode.r(1:2) - r(1:2)),nodes);
   [min_value, index_min] = min(distances);
   
   if precision >= min_value
       result = index_min;
       nodes(index_min).select = ~nodes(index_min).select;
   end
   
end

