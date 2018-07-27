function trajectory = ang2xy(angles,step,x,y)
%ANG2XY Summary of this function goes here
%   Detailed explanation goes here
    vertexs = zeros(1,length(angles)+1,'vertex');
    vertexs(1) = vertex([x y]);
    index = 0;
    for ang=angles
        index = index+1;
        x = vertexs(index).r(1) + step*cos(ang);
        y = vertexs(index).r(2) + step*sin(ang);
        vertexs(index+1) = vertex([x y]);
        
    end
        trajectory = traj(vertexs);
end

