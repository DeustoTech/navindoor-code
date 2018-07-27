classdef BeaconBasedSgnLevel  <  matlab.mixin.SetGet
    %*** BeaconBasedSgnLevel object that represent a signal based of beacons.   
    %*** Descripcion Larga
    %*** plot(x)
    properties
        ms = zeros(0,'ms_node')
    end
    
    properties (SetAccess = immutable)
        
        sgn_function = @(index_beacon,index_node,ilevel,itraj) 1
        beacons = zeros(0,0,'beacon')
        label = 'label'
        type  = 'RSS'
    end
    
    properties (SetAccess = protected)
        level
        hight = 0;
        dt = 0.5
        inequality = '='
        extreme_value = 0
        filterby = 'none'
        len = 0 
        parms_default 
    end
    
    methods
        function obj = BeaconBasedSgnLevel(itraj,ilevel,type,varargin)
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
                case 'RSS'
                    fun_default   = @RSS_dflt;
                    parms_default = {2};
                    label_default = 'RSS Signal';
                case 'ToF'
                    fun_default   = @ToF_dflt;
                    parms_default = {1e-8};        
                    label_default = 'ToF Signal';
                case 'AoA'
                    fun_default   = @AoA_dflt;
                    parms_default = {0.1};     
                    label_default = 'AoA Signal';

            end
            
            addOptional(p,'sgn_function',fun_default);
            addOptional(p,'parameters_sgn',parms_default);
            
            addOptional(p,'label',label_default);
            
            addOptional(p,'dt',0.1,@dt_valid);
            % Go
            parse(p,ilevel,itraj,type,varargin{:})
            
            % asignations optionals
            sgn_function = p.Results.sgn_function;
            parameters_sgn = p.Results.parameters_sgn;
            dt = p.Results.dt;
            label = p.Results.label;
            
            
            %% Immutable properties
            % =============================================================
            obj.dt = dt;
            obj.beacons = ilevel.beacons;
            obj.sgn_function = sgn_function;
            obj.type = type;
            obj.label = label;
            obj.hight = ilevel.high;
            obj.level = ilevel.n;
            %% Init Constructor
            % =============================================================
            obj.len = itraj.len;

            % creamos un nodo con el nivel de la planta
            example_node = node([0 0],itraj.level);
            % creamos una estructura ms_RSS desde el nodo creado
            example_ms = ms_node(example_node,length(ilevel.beacons));
            % alojamos memoria repitiendo el objeto example_RSS
            list_ms_RSS = repmat(example_ms,1,itraj.len);
            
            for index_inode=1:itraj.len
                list_ms_RSS(index_inode).r = itraj.nodes(index_inode).r;
                list_ms_RSS(index_inode).t = itraj.t(index_inode);
                
                list_ms_RSS(index_inode).values = arrayfun( @(ibeacon) ...
                          sgn_function(ibeacon,index_inode,ilevel,itraj,parameters_sgn) ...
                          ,ilevel.beacons);
                      
                list_ms_RSS(index_inode).indexs_beacons = 1:length(ilevel.beacons);
            end
            obj.ms =  list_ms_RSS;
            obj.parms_default = parms_default;
            
        % validations 
            function boolean = traj_valid(itraj)
               boolean = false;
                 if ~isa(itraj,'traj')
                   error('The first parameter, itraj, must be type traj.')
                else
                    boolean = true;
                end              
            end
            function boolean = level_valid(ilevel)
                boolean = false;
                if ~isa(ilevel,'level')
                   error('The second parameter, ilevel, must be type level.')
                else
                    boolean = true;
                end
            end
            function boolean = type_valid(type)
                boolean = false;
                options = {'RSS','ToF','AoA'};
                if ~ismember(type,options)
                    error('The third parameter, type, must be RSS, ToF or AoA.')
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
                z = BeaconBasedSgnLevel;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = BeaconBasedSgnLevel.empty(varargin{:});
             else
             % Use property default values
                z = repmat(BeaconBasedSgnLevel,varargin{:});
             end
          end
       end
end

