function plot(obj,height,parent)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

 
    %
    index = 0;
    found = false; 
    for ipoint = obj.points
        index = index + 1;
        if ipoint.z == height && found == false
            init_index = index;
            final_index = index;
            found = true;
        elseif ipoint.z == height && found == true
            final_index = final_index + 1;
        elseif ipoint.z ~= height && found == true
            points = obj.points(init_index:final_index);
            mt = vec2mat([points.r],3);
            line(mt(:,1),mt(:,2),'Parent',parent)
            init_index = final_index;    
            found = false;
        end
    end

    if found
       points = obj.points(init_index:final_index);
       mt = vec2mat([points.r],3);
       line(mt(:,1),mt(:,2),'Parent',parent,'Marker','.','LineStyle','-')
       
       if length(points) > 1
           x1 =  mt((end-1),1);
           y1 =  mt((end-1),2);

           x2 = mt((end),1);
           y2 = mt((end),2);

           drawArrow([x1 x2],[y1 y2],'Parent', parent);
       end
   end
    
    daspect(parent,[1,1,1])
    parent.XMinorGrid = 'on';
    parent.YMinorGrid = 'on';

end

