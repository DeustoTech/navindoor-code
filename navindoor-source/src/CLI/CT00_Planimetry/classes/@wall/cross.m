        function [boolean,r] = cross(wall1,wall2) 
            %%
    
            x1 = wall1.nodes(1).r(1); y1 = wall1.nodes(1).r(2);
            x2 = wall1.nodes(2).r(1); y2 = wall1.nodes(2).r(2);
            
            
            x3 = wall2.nodes(1).r(1); y3 = wall2.nodes(1).r(2);
            x4 = wall2.nodes(2).r(1); y4 = wall2.nodes(2).r(2);
            
            delta = (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4);
            if delta == 0
               r = [];
               boolean = false;
               return
            else
               x = ((x1*y2-y1*x2)*(x3-x4) - (x1-x2)*(x3*y4-y3*x4))/delta;
               y = ((x1*y2-y1*x2)*(y3-y4) - (y1-y2)*(x3*y4-y3*x4))/delta;
               r = [x,y];
            end
            
            
            if round(y,5)<=round(wall1.intervals.ymax,5) && ...
               round(y,5)>=round(wall1.intervals.ymin,5) && ...
               round(x,5)<=round(wall1.intervals.xmax,5) && ...
               round(x,5)>=round(wall1.intervals.xmin,5) && ...
               round(y,5)<=round(wall2.intervals.ymax,5) && ...
               round(y,5)>=round(wall2.intervals.ymin,5) && ...
               round(x,5)<=round(wall2.intervals.xmax,5) && ...
               round(x,5)>=round(wall2.intervals.xmin,5)
               boolean = true;
            else
               r = [];
               boolean = false;
            end
                          
        end 
