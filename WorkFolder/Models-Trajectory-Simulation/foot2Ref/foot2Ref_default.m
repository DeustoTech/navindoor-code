function RefGroundTruth = foot2Ref_default(FootGroundTruth,varargin)
% description: Convert the Foot GroundTruth to Center of Mass GroundTruth 
    % MandatoryInputs:   
    %       FootGroundTruth: 
    %           description: Object that represent the GroundTruth of Foot
    %           class: GroundTruth
    %           dimension: [1xN]
    % OptionalInputs:
    %       RefFrecuency: 
    %           description: interval of time of mesurements of Center of Mass
    %           class: double
    %           dimension: [1x1]   
    %       building: 
    %           description: Need this to know the hieght of floors
    %           class: building
    %           dimension: [1x1]     
    % Outputs:
    %       RefGroundTruth: 
    %           description: Object that represent the GroundTruth of Center of Mass
    %           class: GroundTruth
    %           dimension: [1xN]  
    
    p = inputParser;
    addRequired(p,'FootGroundTruth')
    addOptional(p,'RefFrecuency',1)
    addOptional(p,'map',[])

    parse(p,FootGroundTruth,varargin{:})
    RefFrecuency = p.Results.RefFrecuency;
    imap = p.Results.map;
    %%
    stances = [FootGroundTruth.Events.stance];
    
    refvalue = ~stances(1);
    
    init_index = 1;
    end_index = 2;
    cont = 0;
    
    index_CoM = [];
    for istances = stances(2:end)
        cont = cont + 1;
        if istances ~= refvalue
            end_index = end_index + 1;
        else
            index_CoM = [index_CoM init_index+floor(cont/2)];
            init_index = init_index + cont;
            end_index = cont + 1;
            cont = 0;
            refvalue = ~refvalue;
        end
    end 
    
    RefEvents = FootGroundTruth.Events(index_CoM);
    timeline  = FootGroundTruth.timeline(index_CoM);
    
    
    new_timeline = timeline(1):(1/RefFrecuency):timeline(end);
    RefEvents = interp1(RefEvents,timeline,new_timeline);
%         
%     height = [building.levels.height];
%     presicion = 0.5;
%     for ih = height
%         zline = [RefEvents.z];
%         index_boleean = abs(zline - ih) < presicion;
%         index = 0;
%         for ib = index_boleean
%             index = index + 1; 
%             if ib
%                 RefEvents(index).z = ih;
%             end
%         end
%    end
    RefGroundTruth = GroundTruth(RefEvents,RefFrecuency,'Ref');
end

