function elevator_ButtonDown(vb1,cnode,option,precision,index_level)
    celevator = elevator;
    celevator.r = cnode.r;
    celevator.level = index_level - 1;

    switch option 
        case 'insert'
            vb1.elevators = [vb1.elevators celevator];
        case 'select'
            if ~isempty(vb1.elevators) || ~isempty(vb1.select_elevators)
                result = select_node(vb1.elevators,vb1.select_elevators,celevator,precision);
                vb1.elevators = result.nodes;
                vb1.select_elevators = result.select_nodes;
            end
    end
end

