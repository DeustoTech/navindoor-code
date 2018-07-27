function obj = compute(obj)
    if ~isempty(obj.initial_function )
        initial_fun_workspace = obj.initial_function(obj,obj.parameters{:});
    else
        initial_fun_workspace = [];
    end

    measurements = cell(1,length(obj.signals));

    mt_estimation = zeros(length(obj.timeline),4); % [x y h t]

    index_t = 1;
    for t = obj.timeline
        index_sng = 0;
        for isignal = obj.signals
            index_sng = index_sng + 1;
            measurements{index_sng} = step(isignal{:},t);
            if isempty(measurements{index_sng}.values)
               %return 
            end
            measurements{index_sng}.type = isignal{:}.type;
        end
        try
            mt_estimation(index_t,1:3) = obj.bucle_function(obj,initial_fun_workspace,measurements,obj.parameters{:});
        catch err
            display('Review the bucle_function.')
            getReport(err,'extended')
            error(['The bucle function have a error. ',err.message])
        end
        index_t = index_t + 1;
    end
    mt_estimation(:,4) = obj.timeline';
    obj.mt_estimation = mt_estimation;
    obj.estimation = mat2supertraj(mt_estimation,obj.building);
    

end
