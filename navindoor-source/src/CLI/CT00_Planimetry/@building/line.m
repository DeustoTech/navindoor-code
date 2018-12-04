function  line(ibuilding,varargin)
%PLOT Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'ibuilding')
    addRequired(p,'Parent',[])

    parse(ibuilding,varargin{:})
    
    Parent = p.Results.Parent;
   
    %%
    if isempty(Parent)
        h.Parent         = figure;
    end
    
    h.ax        = axes('Parent',h.f);
    h.building  = ibuilding;

    nl = length(ibuilding.levels);

    if nl == 0
        return
    end
     
    listbox = uicontrol('Parent',h.f,'style','listbox', ...
                        'String',num2str((1:nl)'),      ...
                        'Callback',{@replot,h},         ...
                        'Units','normalize',            ...
                        'Position',[0.92 0.3 0.06 0.6]);

                    
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
