function plot(obj,index,parent)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

    for itraj = obj.supertraj.trajs
        if itraj.level == index - 1 
            plot(itraj,'Parent',parent,'Marker','.')
        end
    end
    
    for ivertex = obj.vertexs
        if ivertex.level == index - 1 
            line(ivertex,'Parent',parent,'Marker','s','LineStyle','none','Color','g');
        end
    end    
    
    daspect(parent,[1,1,1])
    parent.XMinorGrid = 'on';

end

