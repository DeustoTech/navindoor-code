classdef vertex<node
    %VERTEX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        connections = [];
        generation = 0;
        index = 0
    end
    
    methods
        %% constructor & settings
        function obj = vertex(r,connections)
            obj=obj@node();
            switch nargin
                case 1
                    obj.r = r;
                case 2
                    obj.r = r;
                    obj.connections = connections;                   
            end
        end
        
        
    end
        
    methods (Static)
       function z = zeros(varargin)
         if (nargin == 0)
         % For zeros('Color')
            z = vertex;
         elseif any([varargin{:}] <= 0)
         % For zeros with any dimension <= 0   
            z = vertex.empty(varargin{:});
         else
         % For zeros(m,n,...,'Color')
         % Use property default values
            z = repmat(vertex,varargin{:});
         end
       end
    end
end

