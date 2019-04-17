function plot(obj,ax,varargin)

    if ~exist('ax','var')
        f = figure;
        ax = axes('Parent',f);
    end

    for iobj = obj

        for ilevel = iobj.levels
           line3(ilevel,ax,varargin{:}) 
        end       
        [nrow,ncol] = size(iobj.border.position);
        x = [iobj.border.position(:,1);iobj.border.position(1,1)];
        y = [iobj.border.position(:,2);iobj.border.position(1,2)];
        z = zeros(nrow+1,1);
        line(x,y,z,'Parent',ax)
    end
    view(25,25)
end
