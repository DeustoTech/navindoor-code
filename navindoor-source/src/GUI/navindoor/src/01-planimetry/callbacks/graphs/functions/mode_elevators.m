function mode_elevators(vb,cnode,option,precision,index_level)
    celevator = elevator;
    celevator.r = cnode.r;

    switch option 
        case 'insert'
            vb.elevators = [vb.elevators celevator];
        case 'select'
            if ~isempty(vb.elevators)
                select(vb.elevators,cnode.r,'precision',precision);
            end
    end
end

