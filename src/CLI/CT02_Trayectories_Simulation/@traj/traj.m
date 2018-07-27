classdef traj 
    %% TRAJ is a object that contains all information of a trayectory
    %
    
    properties
        %% Properties that are initialized in the constructor method
        nodes = zeros(0,0,'vertex')
        
        mt = []             % traj as matrix (len x 2)
        distance = 0        % length of this traj, in meters 
        angles              % angles of [1xlen]
        dangles             % differences of angles
        slopes              % slopes 
        dslopes             % differences of slopes
        x = []              % matrix [1xlen] x position in traj
        len = 0             % Length of list of nodes 
        %% Properties that are NOT initialized in the constructor method
        label='traj'        % Label use in plots
        a = []              % matrix [1xlen] aceleration
        v = []              % matrix [1xlen] velocity
        vx = []
        vy = []
        ax = []
        ay = []
        t = []              % matrix [1xlen] time of v and x
        level = 0           % Level where is this traj
        hight = 0
        dt = 0.0

    end
    
%     properties(SetAccess = protected)
%         %% Only used for other method of class
%     end
    
    methods   
        %% Constructor method
        function obj = traj(nodes,varargin)
            
            %% Null constructor
            if nargin == 0
                return
            end
                
            %% Vars Assignment
            p = inputParser;
            p.KeepUnmatched = true;
            
            addRequired(p,'nodes',@nodes_valid)
            addOptional(p,'level',level,@level_valid)
            addOptional(p,'nothing',false)
    
            addOptional(p,'hold_nodes',false)

            
            parse(p,nodes,varargin{:})
            
            ilevel = p.Results.level;
            hold_nodes = p.Results.hold_nodes;
            nothing = p.Results.nothing;
            % ==============
            %% INIT
            % ==============
            
            %% nodes property
            obj.nodes = nodes;           
            obj.len = length(obj.nodes);
            obj.mt = vec2mat([nodes.r],2);
            %% Salida para trayectorias de 3 puntos 
            % si solo tenemos dos nodos no tiene sentido describir mas
            % los angulos, 
            if obj.len < 2
               return 
            end  
        
            %% 
            if ~nothing
                %% x and distance properties
                distance = 0;
                obj.x = zeros(1,obj.len);
                obj.x(1) = 0;
                for index=1:obj.len-1  
                    distbetw =  distn(obj.nodes(index),obj.nodes(index+1));
                    distance = distance +distbetw;
                    obj.x(index+1) = distance;
                end
                obj.distance = distance;
                %% high
                obj.hight = ilevel.high;

                if ~hold_nodes 
                    %% mean step of 0.5m
                    step = 1.0; %m
                    new_linspace = 0:step:obj.distance;
                    new_nodes = zeros(1,length(new_linspace),'vertex');
                    index = 0;
                    for xnew=new_linspace
                        index = index + 1;
                        xnode = interp1(obj.x,obj.mt(:,1),xnew);
                        ynode = interp1(obj.x,obj.mt(:,2),xnew);
                        new_nodes(index) = vertex([xnode ynode]);
                    end
                    %% REPEAT 1 - nodes property
                    obj.nodes = new_nodes;           
                    obj.len   = length(obj.nodes);
                    obj.mt    = vec2mat([obj.nodes.r],2);

                    %% REPEAT 2 - x and distance properties
                    distance = 0;
                    obj.x = zeros(1,obj.len);
                    obj.x(1) = 0;
                    for index=1:obj.len-1  
                        distbetw =  distn(obj.nodes(index),obj.nodes(index+1));
                        distance = distance +distbetw;
                        obj.x(index+1) = distance;
                    end
                    obj.distance = distance;
                end
            end
            
            if obj.len < 3 
               return 
            end
            %% angles and slopes properties 
            obj.angles=zeros(1,obj.len);
            obj.slopes=zeros(1,obj.len);
            for index=2:obj.len
                inode =  obj.nodes(index) - obj.nodes(index-1);
                if ~(inode == node)
                    obj.slopes(index) = inode.r(2)/inode.r(1);
                    obj.angles(index) = atan_2pi(inode.r);
                else
                    obj.slopes(index-1) = obj.slopes(index);
                    obj.angles(index-1) = obj.angles(index);

                end
            end    
            
            
            obj.angles(1) = obj.angles(2) - (obj.angles(3) - obj.angles(2));
            obj.slopes(1) = obj.slopes(2) - (obj.slopes(3) - obj.slopes(2));
            %% derivate angle 
            obj.dangles = gradient(obj.angles)';
            obj.slopes  = gradient(obj.slopes)';
            
            
            for index = 1:obj.len
               if obj.dangles(index) > 0.5*pi
                  obj.dangles(index) = obj.dangles(index) - 0.5*pi;
               elseif obj.dangles(index) < -0.5*pi
                  obj.dangles(index) = obj.dangles(index) + 0.5*pi;
               end
            end

            % ==============
            %% END
            % ==============
            
            %% Validations
            function boolean = nodes_valid(nodes)
                boolean = false;
                if ~isa(nodes,'node')
                   error('The first var must be type node') 
                elseif length(nodes) < 2
                    error('The first var must have at least two nodes')
                else
                    boolean = true;
                end
            end
            function boolean = level_valid(ilevel)
                boolean = false;
                if ~isa(ilevel,'level')
                   error('The parameter level must be type level')
                else
                    boolean = true;
                end
                
            end
        end
    end
 
    %% END Constructor 
    
    
    %% Static Methods
    methods (Static)
      function z = zeros(varargin)
         if (nargin == 0)
            z = traj;
         elseif any([varargin{:}] <= 0)
         % For zeros with any dimension <= 0   
            z = traj.empty(varargin{:});
         else
         % Use property default values
            z = repmat(traj,varargin{:});
         end
      end
   end
end

