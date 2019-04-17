function PlotBuildings(obj,Parent,index_building)
    index = 0;
    for iobj = obj 
        index = index + 1;
        x = [iobj.border.position(:,1);iobj.border.position(1,1)];
        y = [iobj.border.position(:,2);iobj.border.position(1,2)];
        if index ~= index_building
            iobj.graphs_border_buildings = line(x,y,'Parent',Parent,'Color','blue','LineStyle','--','LineWidth',0.25);
        else
            iobj.graphs_border_buildings = line(x,y,'Parent',Parent,'Color','red','LineStyle','-','LineWidth',2.5);
        end
    end
end