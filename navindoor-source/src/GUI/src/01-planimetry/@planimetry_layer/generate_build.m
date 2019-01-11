
function ibuilding = generate_build(obj)

ibuilding = building;
for index_level = 1:length(obj)
    ibuilding.levels(index_level) = level;
    ibuilding.levels(index_level).height        = obj(index_level).height;
    ibuilding.levels(index_level).nodes        = obj(index_level).nodes;
    ibuilding.levels(index_level).walls        = obj(index_level).walls;
    ibuilding.levels(index_level).doors        = obj(index_level).doors; 
    ibuilding.levels(index_level).elevators    = obj(index_level).elevators; 
    ibuilding.levels(index_level).stairs       = obj(index_level).stairs;
    ibuilding.levels(index_level).beacons      = obj(index_level).beacons; 
    ibuilding.levels(index_level).dimensions   = [  obj(index_level).XLim(2)  obj(index_level).XLim(2)];
end
    %% 
    
end



