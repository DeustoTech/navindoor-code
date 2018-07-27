classdef BeaconBasedSgn < handle & matlab.mixin.SetGet
    % *** BEACONBASEDSGN object that represent a signal based of beacons.   
    % *** Descripcion Larga
    % *** plot(x)
    properties
        BeaconBasedSgnLevels        BeaconBasedSgnLevel                                                                         % Signal information by levels 
        intersignal                 cell                                                                = {}                    % Interlevel information of the signal 
        dt_max                      double                                                              = 0                     % Maximum time that exists the signal
        supertraj                   supertraj                                                                                   % Supertraj which it is generate the signal
        build                       build                                                                                       % Build where the supertraj 
        label                       char                                                                = 'Beacon Based Signal' % Name of signal, use to identify Signals in plots
        %
        sgn_function                function_handle                                                                             % Signal function and parameters in level     
        parameters_sgn                                                                                                          % This var is given to sgn_function
        %
        sgn_function_interlevel     function_handle                                                                             % Signal function and parameters in level 
        parameters_sgn_interlevel                                                                                               % This var is given to sgn_function_interlevel
        %  
        beacons                      cell                                                                                       % Cell of beacons by trajs
        % 
        dt                           double             {mustBePositive, mustBeFinite}                  =  0.1                  % Time sampling (in seconds)
        type                         char               {mustBeMember(type,{'RSS','ToF','AoA'})}        = 'RSS'                 % Type of Beacon Signal, this can be {'RSS','ToF','AoA'}  
    end
    
    
    methods
        function obj = BeaconBasedSgn(istraj,ibuild,type,varargin)
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
                % Dependiendo de el type de signal sea seleccionado 
                % los parametros por defectos seran didstintos. De esta forma 
                % simepre existen parametros representativos para signals RSS, ToF o AoA
                case 'RSS'
                    fun_dflt   = @RSS_dflt;
                    parms_dflt = {2.0};
                    
                    fun_inter_default   = @RSS_inter_dflt;
                    parms_inter_default = {2.0};
                    
                    label_dflt = 'RSS Signal';
                case 'ToF'
                    fun_dflt   = @ToF_dflt;
                    parms_dflt = {1e-8};      
                    
                    fun_inter_default   = @ToF_inter_dflt;
                    parms_inter_default = {1e-8};
                    
                    label_dflt = 'ToF Signal';
                case 'AoA'
                    fun_dflt   = @AoA_dflt;
                    parms_dflt = {0.1};     
                    
                    fun_inter_default   = @AoA_inter_dflt;
                    parms_inter_default = {0.1};
                    
                    label_dflt = 'AoA Signal';

            end
            % handle function that transform a trajectory data to signal data in a level.
            addOptional(p,'sgn_function',fun_dflt);
            addOptional(p,'parameters_sgn',parms_dflt,@parameters_sgn_valid);
            % handle function that transform a trajectory data to signal data between two levels.
            addOptional(p,'sgn_function_interlevel',fun_inter_default);
            addOptional(p,'parameters_sgn_interlevel',parms_inter_default,@parameters_sgn_interlevel_valid);
            % label is used to identify a signal. This property is important in iurgui graphical inteface
            addOptional(p,'label',label_dflt);
           
            % we validate all parameters 
            parse(p,ibuild,istraj,type,varargin{:})
            
            % asignations optionals parameters 
            sgn_function = p.Results.sgn_function;
            parameters_sgn = p.Results.parameters_sgn;
                        
            label = p.Results.label;
            sgn_function_interlevel = p.Results.sgn_function_interlevel;
            parameters_sgn_interlevel = p.Results.parameters_sgn_interlevel;
                    
            %% ================================================================
            %  ====================== INIT Constructor ========================
            %% ================================================================

            % Allocate memory 
            obj.BeaconBasedSgnLevels = zeros(1,istraj.len,'BeaconBasedSgnLevel');
            % for each traj of straj generate a signal level.
            for index_traj = 1:istraj.len
                % seleccionamos la trajectoria (traj) y el nivel donde transcurre (ilevel)
                itraj  = istraj.trajs(index_traj);
                ilevel = ibuild.levels(itraj.level + 1);
                
                % add all optionals parameters 
                label_traj = strcat(label,'-' ,num2str(index_traj,'%0.3d'));
                % Para cada tramo creamos un objeto BeaconBasedSgnLevel, (una señal para cada tramo/traj)
                 obj.BeaconBasedSgnLevels(index_traj) = ...
                    BeaconBasedSgnLevel(itraj,ilevel,type,'sgn_function',sgn_function,...
                    'parameters_sgn',parameters_sgn,'label',label_traj);
                
                 % last traj dont have inter signal
                if index_traj ~= istraj.len
                    % la funcion sgn_function_interlevel directamiente nos devuelve 
                    %% obj.intersignal{index_traj} = sgn_function_interlevel(index_traj,istraj,ibuild,parameters_sgn_interlevel);
                      tline = istraj.dt_connections{index_traj}.t;
                      xline = istraj.dt_connections{index_traj}.x;
                      yline = istraj.dt_connections{index_traj}.y;
                      hline = istraj.dt_connections{index_traj}.h;

                      ni = istraj.connections(index_traj).nodes(1).level;
                      nf = istraj.connections(index_traj).nodes(2).level;

                      % aviable beacons in trasition   
                      beacons = [ibuild.levels(ni+1).beacons ibuild.levels(nf+1).beacons];

                      %  
                      nbcni = length(ibuild.levels(ni+1).beacons);
                      beacon_char = strcat(repmat('beacon_',nbcni,1),num2str((1:nbcni)','%0.2d'));
                      level_char  = repmat(['L_',num2str(ni,'%0.2d')],nbcni,1);
                      b1chat = strcat(level_char,'_',beacon_char);
                      %
                      nbcnf = length(ibuild.levels(nf+1).beacons);
                      beacon_char = strcat(repmat('beacon_',nbcnf,1),num2str((1:nbcnf)','%0.2d'));
                      level_char  = repmat(['L_',num2str(nf,'%0.2d')],nbcnf,1);
                      b2chat = strcat(level_char,'_',beacon_char);
                      %
                      if nbcni > 0
                        VarNames = ['time          ';b1chat];
                      end     
                      if nbcnf > 0
                        VarNames = [VarNames;b2chat];
                      end
                      %% Parameters 
                        %
                      len=length(tline);
                      bbsline = zeros(len,length(beacons));
                      for index=1:len
                        x = xline(index);
                        y = yline(index);
                        h = hline(index);
                        index_beacon = 0;
                        
                        for ibeacon = beacons
                            index_beacon = index_beacon + 1;
                            bbsline(index,index_beacon)  = sgn_function_interlevel(x,y,h,ibeacon,index_traj,istraj,ibuild,parameters_sgn_interlevel);
                        end
                      end

                      bbs_matrix = array2table([tline bbsline],'VariableNames',cellstr(VarNames));
                      sz = size(bbs_matrix); 

                      ms_nodes = zeros(sz(1),1,'ms_node');
                      for nrow = 1:sz(1)
                           ms_nodes(nrow).t = bbs_matrix{nrow,1};
                           ms_nodes(nrow).values = bbs_matrix{nrow,2:end};
                           ms_nodes(nrow).indexs_beacons = 1:length(ms_nodes(nrow).values);  
                      end
                      obj.intersignal{index_traj} = ms_nodes;
                end
            end
            
            %%  Signal Properties Asignations
            obj.sgn_function = sgn_function;  
            obj.parameters_sgn = parameters_sgn;
            %
            obj.sgn_function_interlevel = sgn_function_interlevel;
            obj.parameters_sgn_interlevel = parameters_sgn_interlevel;
            %
            obj.dt = istraj.dt;
            obj.beacons = {ibuild.levels.beacons};
            obj.label = label;
            obj.type = type;
            obj.dt_max = istraj.dt_max;
            obj.parameters_sgn = parameters_sgn;
            obj.supertraj = istraj;
            obj.build = ibuild;
            %
            %% Supertraj Properties
            istraj.signals{length(istraj.signals) + 1 } = obj; 
            %
            %% ============================================================
            %  ==================== END Constructor =======================
            %% ============================================================
            %
            %  .----------------. .-----------------..----------------. 
            % | .--------------. | .--------------. | .--------------. |
            % | |  _________   | | | ____  _____  | | |  ________    | |
            % | | |_   ___  |  | | ||_   \|_   _| | | | |_   ___ `.  | |
            % | |   | |_  \_|  | | |  |   \ | |   | | |   | |   `. \ | |
            % | |   |  _|  _   | | |  | |\ \| |   | | |   | |    | | | |
            % | |  _| |___/ |  | | | _| |_\   |_  | | |  _| |___.' / | |
            % | | |_________|  | | ||_____|\____| | | | |________.'  | |
            % | |              | | |              | | |              | |
            % | '--------------' | '--------------' | '--------------' |
            %  '----------------' '----------------' '----------------' 
            % 
            %
            %
            %
            %% ====================================================================================================
            %  ========================= Validations of constructor of this class =================================
            %% ====================================================================================================
            %
            %  .----------------. .----------------. .----------------. .----------------. .----------------. 
            % | .--------------. | .--------------. | .--------------. | .--------------. | .--------------. |
            % | | ____   ____  | | |      __      | | |   _____      | | |     _____    | | |  ________    | |
            % | ||_  _| |_  _| | | |     /  \     | | |  |_   _|     | | |    |_   _|   | | | |_   ___ `.  | |
            % | |  \ \   / /   | | |    / /\ \    | | |    | |       | | |      | |     | | |   | |   `. \ | |
            % | |   \ \ / /    | | |   / ____ \   | | |    | |   _   | | |      | |     | | |   | |    | | | |
            % | |    \ ' /     | | | _/ /    \ \_ | | |   _| |__/ |  | | |     _| |_    | | |  _| |___.' / | |
            % | |     \_/      | | ||____|  |____|| | |  |________|  | | |    |_____|   | | | |________.'  | |
            % | '--------------' | '--------------' | '--------------' | '--------------' | '--------------' |
            %  '----------------' '----------------' '----------------' '----------------' '----------------' 
            
            function boolean = straj_valid(straj)
               boolean = false; 
               if straj.dt == 0 
                  error('The dt properties of supertraj is zero. So supertraj do not have velocity, try use velocity function.')
               else
                   boolean = true;
               end
            end
            function boolean = parameters_sgn_valid(parameters_sgn)
               boolean = false; 
               if ~iscell(parameters_sgn)
                    error('The parameters_sgn paremeter must must type cell. Try type the var with {}')
               else 
                   boolean = true;
               end
            end
            function boolean = parameters_sgn_interlevel_valid(parameters_sgn)
               boolean = false; 
               if ~iscell(parameters_sgn)
                    error('The parameters_sgn_interlevel paremeter must must type cell. Try type the var with {}')
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
            function boolean = build_valid(ibuild)
               boolean =  false;
               if ~isa(ibuild,'build')
                    error('The second parameter, build, must be type build')
               else
                   boolean = true;
               end
            end
        end
    end
end

