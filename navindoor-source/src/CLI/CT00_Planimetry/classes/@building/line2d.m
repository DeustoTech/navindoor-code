function  h = line2d(ibuilding,varargin)
%PLOT Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'ibuilding')
    addOptional(p,'Parent',[])

    parse(p,ibuilding,varargin{:})
    
    Parent = p.Results.Parent;
   
    %%
    if isempty(Parent)
        h.Parent         = figure;
    else
        h.Parent         = Parent;
    end
    
    h.ax        = axes('Parent',h.Parent);
    h.building  = ibuilding;

    nl = length(ibuilding.levels);

    if nl == 0
        return
    end
     
    hbylevel = 0.05;
    Position = [0.92 0.9-nl*hbylevel 0.06 nl*hbylevel];
    
    listbox = uicontrol('Parent',h.Parent,'style','listbox', ...
                        'String',num2str((1:nl)'),      ...
                        'Callback',{@replot,h},         ...
                        'Units','normalize',            ...
                        'Position',Position);

                    
    ilevel = h.building.levels(1);
    h.ax.Title.String = 'Level 1';
    line(ilevel,h.ax)

end

function replot(object,event,h)

    delete(h.ax.Children)
    ilevel = h.building.levels(object.Value);
    line(ilevel,h.ax)
    h.ax.Title.String = ['Level ',num2str(object.Value)];
    
end
