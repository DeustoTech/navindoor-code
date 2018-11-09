function mode_beacons(vb,cnode,option,precision,index_level)
    switch option 
        case 'insert'
            cbeacons = beacon(cnode.r,'level',index_level-1);
            vb.beacons = [vb.beacons cbeacons];
        case 'select'
            if ~isempty(vb.beacons) 
                select(vb.beacons,cnode.r,'precision',precision);
            end
    end
end

