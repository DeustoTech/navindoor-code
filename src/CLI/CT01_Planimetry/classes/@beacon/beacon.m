classdef beacon<node
    %DOOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        frecuency = 1;
    end
    
    methods
        %% constructor & settings
        function obj = beacon(r,varargin)
            %% Null element
            if nargin == 0
               return 
            end
            %% Parameters Assignment
            
            % Cacth default values of father class
            default_node = node;
            default_level = default_node.level;

            p = inputParser;
            addRequired(p,'r',@valid_r)
            addOptional(p,'level',default_level,@valid_level)
            addOptional(p,'frecuency',1,@valid_frecuency)

            parse(p,r,varargin{:})
            obj.r     = p.Results.r;
            obj.level = p.Results.level;
            obj.frecuency = p.Results.frecuency;


            %% Validations 
            %  ===========
            function boolean = valid_r(ir)
               boolean = false;
               if ~isnumeric(ir) 
                   error("The first parameter 'r' must be numeric.")
               elseif length(ir) ~= 2
                   error("The first parameter 'r' must be bidimensional.")
               else 
                   boolean = true;
               end
            end
            function boolean = valid_level(ilevel)
               boolean = false;
               if ~isnumeric(ilevel) 
                   error("The parameter 'level' must be numeric.")
               elseif ~(ilevel == floor(ilevel))
                   error("The parameter 'level' must be integer.")
               else 
                   boolean = true;
               end
            end
            function boolean = valid_frecuency(frecuency)
                boolean = false;
               if ~isnumeric(frecuency) 
                   error("The parameter 'width' must be numeric.")
               elseif frecuency <= 0
                   error("The parameter 'width' must be positive.")
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
                z = beacon;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = beacon.empty(varargin{:});
             else
             % Use property default values
                z = repmat(beacon,varargin{:});
             end
          end
       end
    
end

