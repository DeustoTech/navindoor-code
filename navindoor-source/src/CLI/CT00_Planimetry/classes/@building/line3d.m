function line3d(ibuilding,varargin)
%INE3D Summary of this function goes here
%   Detailed explanation goes here
p = inputParser;
addRequired(p,'ibuilding')
addOptional(p,'Parent',[])

parse(p,ibuilding,varargin{:})

Parent = p.Results.Parent;

if isempty(Parent)
    f = figure;
    Parent = axes('Parent',f);
end

for ilevel = ibuilding.levels
    line3(ilevel,Parent)
end
Parent.View = [45 45];
Parent.ZGrid = 'on';

Parent.XGrid = 'on';
Parent.YGrid = 'on';

end

