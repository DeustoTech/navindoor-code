function RefGroundTruth = foot2Ref_default(FootGroundTruth,varargin)
%FOOT2COM_DEFAULT Convierte la trajectoria del pie a la trayectoria del centro de masas,

    p = inputParser;
    addRequired(p,'FootGroundTruth')
    addOptional(p,'RefFrecuency',5)
    
    parse(p,FootGroundTruth,varargin{:})
    RefFrecuency = p.Results.RefFrecuency;
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
        
    RefGroundTruth = GroundTruth(RefEvents,RefFrecuency,'Ref');
end

