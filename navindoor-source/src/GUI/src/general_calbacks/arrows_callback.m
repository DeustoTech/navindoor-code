function arrows_callback(h,type)
%ARROWS_CALLBACK Summary of this function goes here
%   Detailed explanation goes here
    listbox_level = findobj_figure(h.iur_figure,'Planimetry','Control','Levels','listbox');
    index_level = listbox_level.Value;
    
    lstep = 0.15;
    switch type 
        case 'rightarrow'
            r = [ lstep 0];
        case 'leftarrow'
            r = [-lstep 0];
        case 'uparrow'
            r = [0 lstep];
        case 'downarrow'
            r = [0 -lstep];
    end
    %% PNG Select || move button pulse 
     btnmove = findobj_figure(h.iur_figure,'Planimetry','PNG File','btnmove');
     if btnmove.Value
        movePNG(h.planimetry_layer(index_level),r)
        return
     end
    %% node select     
    if ~isempty(h.planimetry_layer(index_level).nodes)
        boolean_index = [h.planimetry_layer(index_level).nodes.select] == 1;
        for index = 1:length(h.planimetry_layer(index_level).nodes)
            if boolean_index(index)
                h.planimetry_layer(index_level).nodes(index).r(1) = h.planimetry_layer(index_level).nodes(index).r(1) + r(1);
                h.planimetry_layer(index_level).nodes(index).r(2) = h.planimetry_layer(index_level).nodes(index).r(2) + r(2);
            end
        end
    end
    %% beacons select 
    if ~isempty(h.planimetry_layer(index_level).beacons)
        boolean_index = [h.planimetry_layer(index_level).beacons.select] == 1;

        for index = 1:length(h.planimetry_layer(index_level).beacons)
            if boolean_index(index)
                h.planimetry_layer(index_level).beacons(index).r(1) = h.planimetry_layer(index_level).beacons(index).r(1) + r(1);
                h.planimetry_layer(index_level).beacons(index).r(2) = h.planimetry_layer(index_level).beacons(index).r(2) + r(2);
            end
        end
    end
    %% stairs select 
    if ~isempty(h.planimetry_layer(index_level).stairs)
        boolean_index = [h.planimetry_layer(index_level).stairs.select] == 1;

        for index = 1:length(h.planimetry_layer(index_level).stairs)
            if boolean_index(index)
                h.planimetry_layer(index_level).stairs(index).r(1) = h.planimetry_layer(index_level).stairs(index).r(1) + r(1);
                h.planimetry_layer(index_level).stairs(index).r(2) = h.planimetry_layer(index_level).stairs(index).r(2) + r(2);
            end
        end
    end
    %% elevators select 
    if ~isempty(h.planimetry_layer(index_level).elevators)
        boolean_index = [h.planimetry_layer(index_level).elevators.select] == 1;

        for index = 1:length(h.planimetry_layer(index_level).elevators)
            if boolean_index(index)
                h.planimetry_layer(index_level).elevators(index).r(1) = h.planimetry_layer(index_level).elevators(index).r(1) + r(1);
                h.planimetry_layer(index_level).elevators(index).r(2) = h.planimetry_layer(index_level).elevators(index).r(2) + r(2);
            end
        end
    end    

        %% door select 
    if ~isempty(h.planimetry_layer(index_level).doors)
        boolean_index = [h.planimetry_layer(index_level).doors.select] == 1;

        for index = 1:length(h.planimetry_layer(index_level).doors)
            if boolean_index(index)
                h.planimetry_layer(index_level).doors(index).r(1) = h.planimetry_layer(index_level).doors(index).r(1) + r(1);
                h.planimetry_layer(index_level).doors(index).r(2) = h.planimetry_layer(index_level).doors(index).r(2) + r(2);
            end
        end
    end  
    update_planimetry_layer(h,'replot',true)
end

