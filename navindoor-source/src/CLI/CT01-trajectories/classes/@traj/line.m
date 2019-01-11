function line(itraj,ilevel,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here

    p = inputParser;
    addRequired(p,'itraj')
    addRequired(p,'ilevel')
    addOptional(p,'Parent',[])
    addOptional(p,'Color','r')

    parse(p,itraj,ilevel,varargin{:})

    Parent = p.Results.Parent;
    Color = p.Results.Color;

    if isempty(Parent)
        f = figure;
        Parent = axes('Parent',f);
    end

    zline = abs([itraj.GroundTruths.Ref.Events.z] - ilevel.height);


    index_boolean = zline < 1.0;


    Events = itraj.GroundTruths.Ref.Events(index_boolean);

    xline = [Events.x];
    yline = [Events.y];

    line(xline,yline,'Parent',Parent,'Marker','.','Color',Color)
end

