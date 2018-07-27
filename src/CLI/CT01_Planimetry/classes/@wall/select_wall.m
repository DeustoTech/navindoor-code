function result = select_wall(walls,select_walls,cnode,precision)
 %%
    pnode = [];
    len = length(select_walls)+length(walls);
    dist_wall = zeros(len,1);
    node_wall = zeros(len,2);

    cont=0;
    for iwall=[ walls select_walls ]
        cont=cont+1;
        dm = distw(iwall,cnode);
        dist_wall(cont) = dm.distance;   
        node_wall(cont,:) = dm.r;

    end

    [dmin,index] = min(dist_wall);                    
    if dmin < precision
        if index <= length(walls) 
            pnode = node_wall(index,:);
            select_walls = [ select_walls walls(index)];
            walls(index) = [];
        else
            pnode = node_wall(index,:);
            walls = [walls select_walls(index-length(walls))];
            select_walls(index-length(walls)+1)=[];
        end  
    end

    result = { walls select_walls pnode };
end