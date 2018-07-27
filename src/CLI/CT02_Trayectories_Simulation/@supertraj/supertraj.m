classdef supertraj < handle & matlab.mixin.SetGet
    % *** supertraj es un objecto que generaliza el objecto traj, este es capaz de generar trajectorias que transcurren en varias plantas.   
    % *** 
    % ***  
    
% The descriptions of the properties have functionality so we must follow the scheme that follows:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% function_gui *** Description
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - function_gui ___: It is a function associated to a graphic interface, which allows to modify the value of the property through it.
% This is used by the TableOfObjects interface. Very important in the development of the navindoor framework. All
% functions must be written with the first letter @ otherwise, it will be understood that this property has no GUI, associated
% - Description ____: In the TableOfObjects interface, the description is shown, so it is advisable to write a short description for
% each property.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties
        trajs                                                            = zeros(0,0,'traj')              % none     *** Lista de Trayectorias, contiene toda la información de la trayectoria por plantas
        connections                                                      = zeros(0,0,'connection')        % none     *** Contiene las conexiones que atravieza la supertrayectoria, estos son elementos definidos por la clase build
        dt_connections                                                                                    % none     *** Contiene una tabla que representa la trayectoria cuando se esta cambiando de nivel.
        len                                                                                               % none     *** Número de trajectorias (objectos traj por cada planta)
        dt                  double     {mustBeNonnegative, mustBeFinite} = 0.0                            % none     *** Tiempo de sampling
        dt_max              double     {mustBeNonnegative, mustBeFinite} = 0                              % none     *** Tiempo máximo en el que esta definido la trajectoria
        signals             cell                                         = {}                             % none     *** Cuando se genera una señal, a partir de este objecto. Se guarda la señal generada.  
        label               char                                                                          % @guichar *** Identificador utilizado en la gráficas
        mt_time                                                                                           % none     *** Contiene toda la informacion de la trayectoria en 4 columnas [x y h t]
    end
    
    
    methods
        function obj = supertraj(vertexs,connections,varargin)
            %SUPERTRAJ Construct an instance of this class
            %   Detailed explanation goes here
            
            %% Zero Constructor
            if nargin == 0
                return
            end
            
            %% Vars Assignment
            p = inputParser;
            p.KeepUnmatched = true;
            
            addRequired(p,'vertexs',@vertex_valid)
            addRequired(p,'connections',@connections_valid)
            addOptional(p,'build',[],@ibuild_valid)
            addOptional(p,'dt_connections',[],@dt_connections_valid)
            addOptional(p,'dt',0.0,@dt_valid)
            addOptional(p,'hold_nodes',false)
            addOptional(p,'nothing',false)

            parse(p,vertexs,connections,varargin{:})
            dt             = p.Results.dt;
            dt_connections = p.Results.dt_connections;
            ibuild         = p.Results.build;
            hold_nodes     = p.Results.hold_nodes;
            nothing        = p.Results.nothing;
            %% Init
            obj.trajs = zeros(1,10,'traj');
            actual_vertexs = zeros(1,10,'vertex');
            index_actual_vertex = 1;
            actual_vertexs(1) = vertexs(1);
            index_trajs = 1;
            nlevel = vertexs(1).level;
            for ivertex=vertexs(2:end)
                if ivertex.level == nlevel
                    index_actual_vertex = index_actual_vertex + 1 ;
                    actual_vertexs(index_actual_vertex) = ivertex;
                else
                    if index_actual_vertex > 1
                        obj.trajs(index_trajs)=traj(actual_vertexs(1:index_actual_vertex),'hold_nodes',hold_nodes,'nothing',nothing);
                        obj.trajs(index_trajs).level = nlevel;
                        index_actual_vertex = 1;
                        index_trajs = index_trajs + 1;
                        
                        actual_vertexs(1) = ivertex;
                        nlevel = ivertex.level;
                    end
 
                end
            end
            if index_actual_vertex > 1
                obj.trajs(index_trajs)=traj(actual_vertexs(1:index_actual_vertex),'hold_nodes',hold_nodes,'nothing',nothing);
                obj.trajs(index_trajs).level = nlevel;

            end
            obj.trajs = obj.trajs(1:index_trajs);
            obj.connections = connections;
            obj.len = length(obj.trajs);
            obj.dt_connections = dt_connections;
            
            %%            
            
            %%
            if ~isempty(ibuild)
                for index = 1:obj.len
                    n = obj.trajs(index).level;
                    obj.trajs(index).hight = ibuild.height_levels(n+1);
                end
            end
            obj.dt = dt;

            function boolean = ibuild_valid(ibuild)
                boolean = true;
                if ~(isa(ibuild,'build')||isa(ibuild,'double'))                       
                    error('The parameter ibuild must be type build or []')
                elseif  isa(ibuild,'double') && ~isempty(ibuild) 
                    error('The parameter ibuild must be type build or []')
                else
                    boolean = true;
                end
            end
            function boolean=vertex_valid(vertex)
                boolean = true;
            end
            function boolean=connections_valid(connections)
                boolean = true;
            end
            function boolean=dt_connections_valid(dt_connections)
                boolean = true;
            end
            function boolean=dt_valid(dt)
                boolean = false;
                if ~isnumeric(dt)
                    error('The parameter dt must be numeric')
                else
                    boolean = true;
                end
            end
        end
    end       

end

