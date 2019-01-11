function line(iGroundTruth,ilevel,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here

    p = inputParser;
    addRequired(p,'iGroundTruth')
    addRequired(p,'ilevel')
    addOptional(p,'Parent',[])
    addOptional(p,'Color','r')

    parse(p,iGroundTruth,ilevel,varargin{:})

    Parent = p.Results.Parent;
    Color = p.Results.Color;

    if isempty(Parent)
        f = figure;
        Parent = axes('Parent',f);
    end

    zline = abs([iGroundTruth.Events.z] - ilevel.height);


    index_boolean = zline < 1.0;


    Events = iGroundTruth.Events(index_boolean);

    xline = [Events.x];
    yline = [Events.y];

    line(xline,yline,'Parent',Parent,'Marker','.','Color',Color)
end

