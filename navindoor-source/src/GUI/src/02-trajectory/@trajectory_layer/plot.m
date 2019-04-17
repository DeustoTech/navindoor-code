function varargout = plot(obj,Indexs,parent)
% Digujamos los puntos asociadaos a la trayectoria seleccionada. Indexs nos
% indica la vista que tenemos activada, Parent los ejes donde se dibujaran

    %
    IndexBuilding  = Indexs(1);
    IndexLevel     = Indexs(2);
    
    
    
    index = 0;
    found = false; 
    
    Graphs = gobjects(0);
    for ipoint = obj.points
        index = index + 1;
        
        if (ipoint.IndexBuilding == IndexBuilding && ipoint.IndexLevel == IndexLevel) && found == false
            init_index = index;
            final_index = index;
            found = true;
        elseif (ipoint.IndexBuilding == IndexBuilding && ipoint.IndexLevel == IndexLevel) && found == true
            final_index = final_index + 1;
        elseif ~(ipoint.IndexBuilding == IndexBuilding && ipoint.IndexLevel == IndexLevel) && found == true
            points = obj.points(init_index:final_index);
            mt = vec2mat([points.r],3);
            Graphs = [Graphs ,line(mt(:,1),mt(:,2),'Parent',parent)];
            init_index = final_index;    
            found = false;
        end
    end

    if found
       points = obj.points(init_index:final_index);
       mt = vec2mat([points.r],3);
       Graphs = [Graphs,line(mt(:,1),mt(:,2),'Parent',parent,'Marker','.','LineStyle','-')];
       
       if length(points) > 1
           x1 =  mt((end-1),1);
           y1 =  mt((end-1),2);

           x2 = mt((end),1);
           y2 = mt((end),2);

           Graphs = [Graphs,drawArrow([x1 x2],[y1 y2],'Parent', parent)];
       end
   end
    
    %daspect(parent,[1,1,1])
    parent.XMinorGrid = 'on';
    parent.YMinorGrid = 'on';
    
    if nargout > 0
       varargout{1} = Graphs; 
    end
        
end

