function add(obj,vertex,father_index)
    %% ADD 
    % function that add vertex in network class 
    % INPUTS:
    %   - obj_______: object of network class 
    %   - vertex____: object of vertex class, that will add in network
    % OUTPUTS:
    %   - Nothing, because network is a handle object  
    % EXAMPLE:
    % 
    
    obj.len = obj.len +1;
    obj.vertexs = [obj.vertexs vertex];
    if obj.len > 1
        obj.vertexs(obj.len).connections = father_index;
        obj.vertexs(father_index).connections = [ obj.vertexs(father_index).connections obj.len ];
        obj.branchs =[ obj.branchs wall([obj.vertexs(father_index),vertex])];
    end
end 