function segments = points2segments(ipoints,imap)
% Function que transforma una sequencia de puntos en segmentos. Estos se
% dividen cuando existe algun cambio de planta
    z0 = ipoints(1).z;
    %%
    init_index = 1;
    end_index  = 1;
    segments = [];
    
    
    for ipoint = ipoints
        z = ipoint.z;

        if z0 == z
            end_index = end_index + 1;
        else 
            isegment        = segment;
            isegment.points = ipoints(init_index:(end_index-1));
            isegment.type   = 'byFloor';
            
            jsegment        = segment;
            jsegment.points = ipoints((end_index-1):(end_index));
            % select the level 
            if ipoint.IndexBuilding == -100
                jsegment.type   = 'byElevator';
            else
                ilevel = imap.buildings(ipoint.IndexBuilding).levels(ipoint.IndexLevel) ;

                if ~isempty(ilevel.elevators)
                    distances = arrayfun(@(ielevator) norm(ielevator.r - ipoints(end_index).r) ,ilevel.elevators);
                    min_elevator = min(distances);
                else
                    min_elevator = Inf;
                end
                if ~isempty(ilevel.stairs)
                    distances = arrayfun(@(istairs) norm(istairs.r - ipoints(end_index).r) ,ilevel.stairs);
                    min_stairs = min(distances);
                else
                    min_stairs = Inf;
                end

                if min_elevator < min_stairs
                    jsegment.type   = 'byElevator';
                elseif min_elevator > min_stairs
                    jsegment.type   = 'byStairs';
                else 
                    jsegment.type   = 'byElevator';
                end             
            end


            end_index      = end_index + 1;
            init_index     = end_index;
            z0             = ipoints(end_index).z;
            
            segments = [segments,isegment,jsegment];
        end        
    end
    
    isegment        = segment;
    isegment.points = ipoints(init_index:(end_index-1));
    isegment.type   = 'byFloor';

    segments = [segments,isegment];
    
    
end

