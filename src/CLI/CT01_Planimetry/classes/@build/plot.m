function plot(build)
    %% PLOT 
    % 3D View of building 
    for lvl=build.levels
        plot3(lvl)
    end
    hold on
    if ~isempty(build.connections)
        plot3(build.connections,'Color','black','LineWidth',3,'build',build)
    end
end
