function ostraj = mat2supertraj(mat,ibuild)
%MAT2SUPERTRAJ Summary of this function goes here
%   Detailed explanation goes here
    %% Assignment entry vars
    p = inputParser;
    [nrow,ncol] = size(mat);
    addRequired(p,'mat',@(mat) mat_valid(mat,ncol))
    addRequired(p,'ibuild',@ibuild_valid)
    
    parse(p,mat,ibuild)
    %% Init 

    t0 = 0;
    
    size_trajs = [];
    sizeinterlevel = [];
    
    sz = 0;
    inlevel = true;

    for index = 1:nrow
        % Recorremo la matrix
        h = mat(index,3);
        sz = sz + 1;
      
        if h == floor(h)
            if ~inlevel
               sizeinterlevel = [sizeinterlevel sz-1];
               sz = 1;
               inlevel = true;
            end 
        else
            if inlevel
                size_trajs = [size_trajs sz-1];
                sz = 1;
                inlevel = false;
            end
        end
    end
    
    if isempty(size_trajs)
        size_trajs = sz;
    end
    ostraj = supertraj;
    ostraj.trajs = zeros(1,length(size_trajs),'traj');
    
    index = 0;
    for st = size_trajs
         index = index + 1;
         ostraj.trajs(index).nodes = zeros(1,st,'vertex');
         ostraj.trajs(index).v = zeros(1,st);
         ostraj.trajs(index).x = zeros(1,st);
         ostraj.trajs(index).t = zeros(1,st);
         ostraj.trajs(index).a = zeros(1,st);
    end
      
    dt_connections = {};
    index = 0;
    for si = sizeinterlevel
        index = index + 1;
        matriz = zeros(sizeinterlevel(index),4);
        dt_connections{index} = array2table(matriz,'VariableNames',{'t','x','y','h'});
    end
    ostraj.dt_connections = dt_connections;
    
    id_node = 0;
    id_traj = 1;
    inlevel = true;
    for index = 1:nrow
        x = mat(index,1); y=mat(index,2);h = mat(index,3); t = mat(index,4);
        if h == floor(h)
            if ~inlevel
               t0 = t;
               inlevel = true;
               id_traj = id_traj + 1;
               id_node = 1;
               [~,ind_min] = min(ibuild.height_levels - h);
               ivertex = vertex([x y]);ivertex.level = ind_min - 1;
               ostraj.trajs(id_traj).level = ind_min - 1;
               ostraj.trajs(id_traj).nodes(1) = ivertex;
            else
               id_node = id_node + 1;
               [~,ind_min] = min(ibuild.height_levels - h);
               ivertex = vertex([x y]);ivertex.level = ind_min - 1;
               ostraj.trajs(id_traj).nodes(id_node) = ivertex;   
               ostraj.trajs(id_traj).t(id_node) = t - t0;
            end 
        else
            if inlevel
                t0 = t;
                inlevel = false;
                id_node = 1;
                ostraj.dt_connections{id_traj}.x(1) = x;
                ostraj.dt_connections{id_traj}.y(1) = y;
                ostraj.dt_connections{id_traj}.t(1) = t - t0;
                ostraj.dt_connections{id_traj}.h(1) = h;
                
            else
                id_node = id_node + 1;
                ostraj.dt_connections{id_traj}.x(id_node) = x;
                ostraj.dt_connections{id_traj}.y(id_node) = y;
                ostraj.dt_connections{id_traj}.t(id_node) = t - t0;
                ostraj.dt_connections{id_traj}.h(id_node) = h;
            end
        end
    end
    
    
    ostraj.len = length(ostraj.trajs);
    %%
    
    for index_traj = 1:ostraj.len
         tline = ostraj.trajs(index_traj).t;
         if length(ostraj.trajs(index_traj).nodes) == 1
             ostraj.trajs(index_traj+1).nodes = [ ostraj.trajs(index_traj+1).nodes ostraj.trajs(index_traj).nodes];
             continue 
         end
         ostraj.trajs(index_traj)   = traj(ostraj.trajs(index_traj).nodes,'hold_nodes',true);
         ostraj.trajs(index_traj).t = tline;
         ostraj.trajs(index_traj).v = gradient(ostraj.trajs(index_traj).t ,ostraj.trajs(index_traj).x );
         ostraj.trajs(index_traj).a = gradient(ostraj.trajs(index_traj).t ,ostraj.trajs(index_traj).v );
         if index_traj ~= ostraj.len
            x = ostraj.trajs(index_traj).nodes(end).r(1);
            y = ostraj.trajs(index_traj).nodes(end).r(2);
            index_level = ostraj.trajs(index_traj).level + 1;
            ostraj.connections(index_traj) = select_connection(x,y,index_level,ibuild);
         end
    end
    
    ostraj.mt_time = mat;
    
    dt = ostraj.trajs(index_traj).t(2) - ostraj.trajs(index_traj).t(1);
    ostraj.dt = dt;
    ostraj.dt_max = mat(end,4);

    for index_traj = 1:ostraj.len
        ostraj.trajs(index_traj).dt = dt;
    end
    
end
%% Inner Functions 
function iconn = select_connection(x,y,index_level,ibuild)
    inode = node([x y]);
    ilevel = ibuild.levels(index_level);
    stairs = ilevel.stairs;
    min_s = Inf; min_e = Inf;
    if ~isempty(stairs)
        distance_stairs = distn(inode,stairs);
        [min_s , ind_s] = min(distance_stairs);
    end
    elevators = ilevel.elevators;
    if ~isempty(elevators)
        distance_elevator = distn(inode,elevators);
        [min_e , ind_e] = min(distance_elevator);
    end

    if min_e < min_s
        element = elevators(ind_e);
    else
        element = stairs(ind_s);
    end
    
    for iconn = ibuild.connections
        if iconn.nodes(1).level == index_level-1 && iconn.nodes(1) == element
            return 
        elseif iconn.nodes(2).level == index_level-1 && iconn.nodes(2) == element
            return 
        end         
    end
end
%% Validations
function boolean = mat_valid(mat,ncol)
    boolean = false;
    if ~isnumeric(mat)
        error('The first parameter must be double matrix.')
    elseif ~(ncol == 4)
        error('The entry matrix only can have a 6 columns. The format is [x y h t]')
    elseif length(unique(round(diff(mat(:,4)),8))) ~= 1
        error('The sixth column, the timeline, must be equitime.')
    else 
        boolean = true;
    end
end

function boolean = ibuild_valid(ibuild)
    boolean = true;
end
