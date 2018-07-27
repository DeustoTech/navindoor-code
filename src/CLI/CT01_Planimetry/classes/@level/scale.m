function new_level=scale(ilevel,x,y)
    new_nodes = scale(ilevel.nodes,x,y);
    new_walls = scale(ilevel.walls,x,y);
    new_doors = scale(ilevel.doors,x,y);
    new_beacons =  scale(ilevel.beacons,x,y);
    new_dimensions = [x*ilevel.dimensions(1) y*ilevel.dimensions(2)];
    new_level=level(new_nodes,new_walls,new_doors,new_beacons,new_dimensions);
    new_elevators = scale(ilevel.elevators,x,y);
    new_level.elevators = new_elevators;
end
