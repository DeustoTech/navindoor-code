function result = plot(nodes,varargin)
    %% plot list of nodes 
    
    
    % validations 
    mt_nodes = vec2mat([nodes.r],2);
    dx = mt_nodes(:,1);
    dy = mt_nodes(:,2);
    result = plot(dx,dy,varargin{:});
    
    if isa(nodes,'beacon')
        len = length(nodes);
        text(dx,dy,strcat(repmat('AP_{',len,1),num2str((1:len)','%.3d'),'}'),'FontSize',12)
    end
    
    if isa(nodes,'stairs')
        len = length(nodes);
        text(dx,dy,strcat(repmat('Stairs_{',len,1),num2str((1:len)','%.3d'),'}'),'FontSize',12)
    end
    
     if isa(nodes,'elevator')
        len = length(nodes);
        text(dx,dy,strcat(repmat('Elevator_{',len,1),num2str((1:len)','%.3d'),'}'),'FontSize',12)
    end   
end
