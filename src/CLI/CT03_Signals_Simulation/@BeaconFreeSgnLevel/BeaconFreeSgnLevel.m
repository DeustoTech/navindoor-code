classdef BeaconFreeSgnLevel
    %SIGNAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ms = zeros(0,'ms_node')
    end
    
    properties (SetAccess = immutable)
        
        sgn_function = @(index_beacon,index_node,ilevel,itraj) 1
        dim_signal
        label 
        type 
    end
    
    properties (SetAccess = protected)
        dt = 0.5
        NumMaxAps = 0
        direction = 'none'
        orderby = 'none'
        len = 0 
    end
    
    methods
        function obj = BeaconFreeSgnLevel(itraj,ilevel,type,varargin)
            %SIGNAL Construct an instance of this class
            %   Signal generation in level
            %% Zero element
            if nargin == 0 
                return
            end            
            %% Parameters Asignment
            p = inputParser;p.KeepUnmatched = true; % active, if ther are optionals parameters 

            % Mandatories
            addRequired(p,'ilevel',@level_valid);
            addRequired(p,'itraj',@traj_valid);
            addRequired(p,'type',@type_valid);

            % Optionals 
            type_valid(type);
            switch type 
                case 'Acel'
                    fun_default   = @Acel_dflt;
                    parms_default = {0.1};
                    label_default = 'Acel Signal';
                case 'Gyro'
                    fun_default   = @Gyro_dflt;
                    parms_default = {0.1};        
                    label_default = 'Gyro Signal';
                case 'Baro'
                    fun_default   = @Baro_dflt;
                    parms_default = {0.5};        
                    label_default = 'Baro Signal';
                case 'Magne'
                                        
                    fun_default   = @Magne_dflt;
                    parms_default = {0.5};        
                    label_default = 'Magne Signal';

            end
            addOptional(p,'sgn_function',fun_default);
            addOptional(p,'parameters_sgn',parms_default);
            
            addOptional(p,'label',label_default);
            
            % Go
            parse(p,ilevel,itraj,type,varargin{:})
            
            % asignations optionals
            sgn_function = p.Results.sgn_function;
            parameters_sgn = p.Results.parameters_sgn;
            label = p.Results.label;
            
            %% Immutable properties
            % =============================================================
            obj.sgn_function = sgn_function;
            obj.type = type;
            obj.label = label;
            obj.dt = itraj.dt;
            %% Init Constructor
            % =============================================================
            obj.len = itraj.len;

            % creamos un nodo con el nivel de la planta
            example_node = node([0 0],itraj.level);
            % creamos una estructura ms_RSS desde el nodo creado
            example_ms = ms_node(example_node,1);
            % alojamos memoria repitiendo el objeto example_RSS
            list_ms_RSS = repmat(example_ms,1,itraj.len);
            
            
            for index_inode=1:itraj.len
                list_ms_RSS(index_inode).r = itraj.nodes(index_inode).r;
                list_ms_RSS(index_inode).t = itraj.t(index_inode);
                
                list_ms_RSS(index_inode).values = sgn_function(index_inode,ilevel,itraj,parameters_sgn);
            end
            obj.ms =  list_ms_RSS;
            
            obj.sgn_function = sgn_function;
            obj.dim_signal = length(obj.ms(1).values);
            %%
            function boolean = level_valid(ilevel)
                boolean = false;
                if ~isa(ilevel,'level')
                   error('The second parameter, ilevel, must be type level') 
                else
                    boolean = true;
                end
            end
            function boolean = traj_valid(itraj)
                boolean = false;
                if ~isa(itraj,'traj')
                   error('The first parameter, itraj, must be type traj') 
                else
                    boolean = true;
                end
            end    
            function boolean = type_valid(type)
                boolean = false;
                options = {'Baro','Gyro','Magne','Acel'};
                if ~ismember(type,options)
                    error('The third parameter, type, must be Baro, Gyro, Magne or Acel.')
                else
                    boolean = true;
                end
            end
        end
        
    end
    
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = BeaconFreeSgnLevel;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = BeaconFreeSgnLevel.empty(varargin{:});
             else
             % Use property default values
                z = repmat(BeaconFreeSgnLevel,varargin{:});
             end
          end
       end
end

