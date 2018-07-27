function mode_beacons(vb,cnode,option,precision,index_level)
    switch option 
        case 'insert'
            cbeacons = beacon(cnode.r);
            cbeacons.level = index_level - 1;
            vb.beacons = [vb.beacons cbeacons];
        case 'select'
            if ~isempty(vb.beacons) || ~isempty(vb.select_beacons)
                result = select_node(vb.beacons,vb.select_beacons,cnode,precision);
                vb.beacons = result.nodes;
                vb.select_beacons = result.select_nodes;
            end
    end
end

