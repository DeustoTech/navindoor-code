classdef estimator < matlab.mixin.SetGet
    % *** ESTIMATOR es un objecto que puede estimar una supertrajectoria a partir de  .   
    % *** Descripcion Larga
    % *** plot(x)    
    properties
        signals
        building
        
        bucle_function
        initial_function

        initial_state                 % initial state 
        
        estimation
        timeline                      % none   *** Linea de tiempo definida por dt
        dt                            % @guidt *** Frecuencia en la que se pedirá medidas de las señales definidas en signals
        
        type_signal_available         % celda con los tipos de 
        mt_estimation
        
        label                         % @guichar *** Nombre utilizado para la identificación del estimador en la gráficas
        
        parameters                    % @guiparameters *** Parameters disponibles en la funcion bucle_function.
        
    end

    
    
    methods
        function obj = estimator(varargin)
            
            p = inputParser;
            addOptional(p,'signals',[])
            addOptional(p,'building',[])
            
            addOptional(p,'bucle_function',[])
            addOptional(p,'bucle_parameters',[])
            
            addOptional(p,'initial_function',[])
            addOptional(p,'initial_parameters',[])
            
            addOptional(p,'type_signal_available',{'RSS','ToF','Baro'})
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
            
            obj.signals = signals;
            if ~isempty(signals)
               obj.timeline = timeline(signals{1});
               obj.dt       = obj.signals{1}.dt;
            end
        end
    end
end

