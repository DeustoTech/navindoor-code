classdef estimator < matlab.mixin.SetGet
    % *** ESTIMATOR es un objecto que puede estimar una supertrajectoria a partir de  .   
    % *** Example
    % *** plot(x)    
    properties
        signals       = {}                % cell of signals
        building                     % build object
        
        bucle_function                % function that is runned in bucle 
        initial_function              % function in initial function 

        initial_state                 % initial state 
        
        estimation                    % solution
        timeline                      % none   *** Linea de tiempo definida por dt
        dt                            % @guidt *** Frecuencia en la que se pedirá medidas de las señales definidas en signals
        frecuency
        
        type_signal_available         % celda con los tipos de 
        mt_estimation                 % other format of solution
        
        label                         % @guichar *** Nombre utilizado para la identificación del estimador en la gráficas
        
        parameters            = {}        % @guiparameters *** Parameters disponibles en la funcion bucle_function.
       
        beacons                       % list of beacon, the order of this list is important
    end

    methods
        function obj = estimator(varargin)
            
            p = inputParser;
            addOptional(p,'signals',[])
            addOptional(p,'building',[])
            
            addOptional(p,'bucle_function',[])
            addOptional(p,'bucle_parameters',{})
            
            addOptional(p,'initial_function',[])
            addOptional(p,'initial_parameters',{})
            
            addOptional(p,'type_signal_available',{'RSS','ToF','Barometer','InertialFoot'})
            addOptional(p,'initial_state',[0 0 0 0 0])
            
            addOptional(p,'label','estimator_001')

            parse(p,varargin{:})
            %%
            obj.signals = p.Results.signals;
            obj.building = p.Results.building;
            
            obj.bucle_function          = p.Results.bucle_function;
            obj.initial_function        = p.Results.initial_function;
            obj.initial_state           = p.Results.initial_state;
            obj.type_signal_available   = p.Results.type_signal_available;
            obj.label                   = p.Results.label;

            %%
            if  ~isempty(obj.signals)
                obj.timeline = timeline(obj.signals{1});
                obj.dt       = obj.signals{1}.dt;
            end
        end
        
        function obj = set.signals(obj,signals)
            
            BS = false;
            obj.signals = signals;
            if ~isempty(signals)
               
               frecuens = zeros(1,length(signals));
               for index = 1:length(signals)
                    if isa(signals{index},'BeaconSgn')
                       idxBS = index;
                       BS = true; 
                    end
                    frecuens(index) = obj.signals{index}.frecuency;
               end
               [~ ,max_idx] = max(frecuens);
               
               obj.frecuency       = obj.signals{max_idx}.frecuency;
               obj.dt              = 1/obj.frecuency;
               obj.timeline = signals{max_idx}.timeline;
              if BS
                 obj.beacons =  signals{idxBS}.beacons;
              end

            end
        end
    end
end

