classdef door<node
    %DOOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        width = 0.75;
    end
    
    methods
        %% constructor & settings
        function obj = door(r,varargin)
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
            addOptional(p,'width',0.75,@valid_width)

            parse(p,r,varargin{:})
            obj.r     = p.Results.r;
            obj.level = p.Results.level;
            obj.width = p.Results.width;


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
            function boolean = valid_width(width)
                boolean = false;
               if ~isnumeric(width) 
                   error("The parameter 'width' must be numeric.")
               elseif width <= 0
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
                z = door;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = door.empty(varargin{:});
             else
             % Use property default values
                z = repmat(door,varargin{:});
             end
          end
       end
    
end

