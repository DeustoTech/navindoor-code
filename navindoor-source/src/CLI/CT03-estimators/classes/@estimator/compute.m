function obj = compute(obj)

    % Comprobamos si alguna señales es typo Beacon Based
    % Si es asi, recojemos la lista de beacons 

    for isignal = obj.signals
        if isa(isignal{:},'BeaconSgn')
             obj.beacons  = isignal{:}.beacons;
            break
        end
    end
    
    % Puede que no se necesite funcion inicial
    % en caso de que este definida, la ejecutamos
    if ~isempty(obj.initial_function )
        initial_fun_workspace = obj.initial_function(obj,obj.parameters{:});
    else
        initial_fun_workspace = [];
    end
    % C
    measurements = cell(1,length(obj.signals));

    mt_estimation = zeros(length(obj.timeline),4); % [x y h t]

    index_t = 1;
    for t = obj.timeline
        index_sng = 0;
        for isignal = obj.signals
            index_sng = index_sng + 1;
            measurements{index_sng} = step(isignal{:},t);
            if isempty(measurements{index_sng}.values)
               return 
            end
            measurements{index_sng}.type = isignal{:}.type;
            
        end
        try
            mt_estimation(index_t,1:3) = obj.bucle_function(obj,initial_fun_workspace,measurements);
        catch err
            display('Review the bucle_function.')
            getReport(err,'extended')
            error(['The bucle function have a error. ',err.message])
        end
        index_t = index_t + 1;
    end
    mt_estimation(:,4) = obj.timeline';
    obj.mt_estimation = mt_estimation;
    

end
