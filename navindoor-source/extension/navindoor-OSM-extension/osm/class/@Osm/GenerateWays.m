function GenerateWays(obj)

    Ways = OsmWay.empty;
    idx_wy = 0;
    %
    Building = OsmBuilding.empty;
    idx_bl = 0;    
    
    %%
    for iway = obj.xml.way 

        nodes = OsmNode.empty;
        idx_nd = 0;
        for nd = iway{:}.nd
           id = nd{:}.Attributes.ref;
           idx_nd = idx_nd + 1;
           nodes(idx_nd) = FindByID(obj.OsmNodes,id);
        end

        id = iway{:}.Attributes.id;
        %%
        if HasTag(iway{:},'building')
            idx_bl = idx_bl + 1;
            Building(idx_bl) = OsmBuilding(id,nodes);
        else
            idx_wy = idx_wy + 1;
            Ways(idx_wy) = OsmWay(id,nodes);
        end

    end

    obj.OsmWays = Ways;
    obj.OsmBuilding = Building;

end
%%
function boolean = HasTag(iway,k)

    if ~isfield(iway,'tag')
        boolean = false;
        return
    elseif length(iway.tag) < 2
        boolean = strcmp(k,iway.tag.Attributes.k);
    else
        boolean = false;
        for itag = iway.tag
            if strcmp(k,itag{:}.Attributes.k)
                boolean = true;
                return
            end
        end
        
    end
end
