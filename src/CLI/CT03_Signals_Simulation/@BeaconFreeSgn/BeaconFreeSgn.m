classdef BeaconFreeSgn <   matlab.mixin.SetGet
    % *** BeaconFreeSgn object that represent a signal indepenent of beacons.   
    % *** Descripcion Larga
    % *** plot(x)
    properties
        BeaconFreeSgnLevels = zeros(0,0,'BeaconFreeSgnLevel')  % Object that contains all information of signal in each level
        intersignal = {}                                       % Cell of list of ms_node objects
        dt_max = 0                                             % Max time of this signal (in seconds)
        supertraj                                              % Contains the Supertraj parent of this signal
        build                                                  % Building where Supertraj happens
        label = 'BeaconFreeSgn'                                % String used to identify the signal in plots 
        %
        sgn_function                                           % Function that generate the signal in level
        parameters_sgn                                         % Variable that can be use the sgn_function
        %
        sgn_function_interlevel                                % Function that generate the signal between levels
        parameters_sgn_interlevel                              % Variable that can be use the sgn_function_interlevel
        %
        dt = 1                                                 % time of sampling (in seconds)
        type                                                   % The Beacon Free Signals can be: {'Baro','Acel','Magne','Giro'}
        dim_signal                                             % Is is neccesary define that dimension will have the signal
    end
    
    
    methods
        function obj = BeaconFreeSgn(istraj,ibuild,type,varargin)
            %EXTERNALSIGNAL Construct an instance of this class
            %   Detailed explanation goes here
            %% Zero element
            if nargin == 0
               return 
            end
            %% Parameters Asignment
            p = inputParser;p.KeepUnmatched = true; % active, if ther are optionals parameters 

            % Mandatories
            addRequired(p,'ibuild',@build_valid);
            addRequired(p,'istraj',@straj_valid);
            addRequired(p,'type',@type_valid);

            % Optionals 
            type_valid(type);
            switch type 
                case 'Acel'
                    fun_default   = @Acel_dflt;
                    parms_default = {0.1};
                    
                    fun_inter_default   = @Acel_inter_dflt;
                    parms_inter_default = {0.1};

                    label_default = 'Acel Signal';
                case 'Giro'
                    fun_default   = @Giro_dflt;
                    parms_default = {0.1};  
                    
                    fun_inter_default   = @Giro_inter_dflt;
                    parms_inter_default = {0.1};
                    
                    label_default = 'Giro Signal';
                case 'Baro'
                    fun_default   = @Baro_dflt;
                    parms_default = {0.025};   
                    
                    fun_inter_default   = @Baro_inter_dflt;
                    parms_inter_default = {0.025};
                    
                    label_default = 'Baro Signal';
                case 'Magne'
                    fun_default   = @Magne_dflt;
                    parms_default = {0.05};   
                    
                    fun_inter_default   = @Magne_inter_dflt;
                    parms_inter_default = {0.05};
                    
                    label_default = 'Magne Signal';
            end
            
            addOptional(p,'sgn_function',fun_default);
            addOptional(p,'parameters_sgn',parms_default);
 
            addOptional(p,'sgn_function_interlevel',fun_inter_default);
            addOptional(p,'parameters_sgn_interlevel',parms_inter_default);
            
            addOptional(p,'label',label_default);
            
            % Go
            parse(p,ibuild,istraj,type,varargin{:})
            
            % asignations optionals
            sgn_function = p.Results.sgn_function;
            parameters_sgn = p.Results.parameters_sgn;
            label = p.Results.label;
            sgn_function_interlevel = p.Results.sgn_function_interlevel;
            parameters_sgn_interlevel = p.Results.parameters_sgn_interlevel;
            
            % Go
           
            % ============================================================
            % ============================================================
            % ============================================================
            % ============================================================
            %% INIT Constructor 
            %
            %
            
            
            obj.BeaconFreeSgnLevels = zeros(1,istraj.len,'BeaconFreeSgnLevel');

            for index_traj = 1:istraj.len
                itraj  = istraj.trajs(index_traj);
                ilevel = ibuild.levels(itraj.level + 1);
                % add all optionals parameters 
                label_traj = strcat(label,'-' ,num2str(index_traj,'%0.3d'));
                 obj.BeaconFreeSgnLevels(index_traj) = ...
                    BeaconFreeSgnLevel(itraj,ilevel,type,'sgn_function',sgn_function,...
                    'parameters_sgn',parameters_sgn,'label',label_traj);
                % last traj dont have inter signal
                if index_traj ~= istraj.len
                    obj.intersignal{index_traj} = sgn_function_interlevel(index_traj,istraj,ibuild,parameters_sgn_interlevel);
                end
            end
            
           
            %%  Properties
            obj.sgn_function = sgn_function;  
            obj.parameters_sgn = parameters_sgn;
            obj.sgn_function_interlevel = sgn_function_interlevel;
            obj.parameters_sgn_interlevel = parameters_sgn_interlevel;
            
            
            obj.dt = istraj.dt;
            obj.label = label;
            obj.type = type;
            obj.dt_max = istraj.dt_max;
            obj.dim_signal = length(obj.BeaconFreeSgnLevels(1).ms(1).values);
            obj.supertraj = istraj;
            obj.build = ibuild;
            
            istraj.signals{length(istraj.signals) + 1 } = obj; 

            %
            function boolean = build_valid(ibuild)
                boolean = false;
                if ~isa(ibuild,'build')
                   error('The second parameter, ibuild, must be type build') 
                else
                    boolean = true;
                end
            end
            function boolean = straj_valid(istraj)
                boolean = false;
                if ~isa(istraj,'supertraj')
                   error('The first parameter, istraj, must be type supertraj') 
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
            %
            %
            %% END Constructor
            % ============================================================
            % ============================================================
            % ============================================================
            % ============================================================            
        end
    end
end

