function result = distw(obj,r)
    
    %obj: Object and node
    xo = r(1);
    yo = r(2);
    result.distance=-1;
    
    % obj.m == Pendiente de la pared
    if obj.m ~= Inf && obj.m ~= 0 
        x = -(1/(1+obj.m^2))*(obj.n*obj.m-obj.m*yo-xo);
        y = obj.m*x+obj.n;
        xs = [ obj.nodes(1).r(1) obj.nodes(2).r(1)];
        xmax = max(xs);xmin=min(xs);
        if x<xmax && x>xmin
            result.r = [x y];
            result.distance = norm(result.r(1:2) - r(1:2));                 
        end
    elseif obj.m == Inf
        x = obj.nodes(1).r(1);
        y = yo;

        ys = [ obj.nodes(1).r(2) obj.nodes(2).r(2)];
        ymax = max(ys);ymin=min(ys);

        if y<ymax && y>ymin
            result.distance=norm(xo-x);
            result.r=[x y];                 
        end
    elseif obj.m == 0
        y = obj.nodes(1).r(2);
        x = xo;

        xs = [ obj.nodes(1).r(1) obj.nodes(2).r(1)];
        xmax = max(xs);xmin=min(xs);

        if x<xmax && x>xmin
            result.distance=norm(yo-y);
            result.r=[x y];                  
        end                
    end

    if result.distance == -1
        [d, index]=min([norm(r(1:2) - obj.nodes(1).r(1:2))  norm(r(1:2) - obj.nodes(2).r(1:2))]);
        result.distance = d;
        result.r = obj.nodes(index).r(1:2);  
    end

end
