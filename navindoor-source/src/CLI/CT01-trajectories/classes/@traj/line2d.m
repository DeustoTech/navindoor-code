function line2d(itraj,varargin)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

p = inputParser;

addRequired(p,'itraj')
addOptional(p,'building',[])
addOptional(p,'Parent',[])

parse(p,itraj,varargin{:})

Parent = p.Results.Parent;
building = p.Results.building;


if isempty(Parent)
    Parent = figure;
end 


if ~isempty(building)
    h = line2d(building,'Parent',Parent);
    h.traj = itraj;
    h.Parent.Children(1).Callback = {@replot,h};
else
    %% Creamos la estrutura 
end

replot(h.Parent.Children(1),[],h)



end

function replot(object,event,h)

    delete(h.ax.Children)
    ilevel = h.building.levels(object.Value);
    line(ilevel,h.ax)
    
    color = {'r','g','b','k','c','g'};
    
    index_color = 0;
    
    legend_axes = {};

    for itraj = h.traj
        index_color = index_color + 1;
        line(itraj,ilevel,'Parent',h.ax,'Color',color{index_color})
        legend_axes{index_color}= line(NaN,NaN,'Parent',h.ax,'Color',color{index_color});
    end
    
    legend(h.ax,[legend_axes{:}],{h.traj.label})
     
    h.ax.Title.String = ['Level ',num2str(object.Value)];

end
