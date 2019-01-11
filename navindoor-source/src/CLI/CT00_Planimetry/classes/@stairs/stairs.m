classdef stairs<door
    % description: Representacion de una escalera. Es una subclase de la clase door. Esto se debe 
    %              a que dentro del framework las escaleras son mas bien una puerta que te conduce a 
    %              otra planta
    % visible: true
        properties
        % type: double
        % default: none
        % description: able connections to stairs
        connections = []   

    end
    
    methods
        %% constructor & settings
        function obj = stairs(r)
        % description: The stairs constructor need a array double of 3 dimension. 
        % MandatoryInputs:   
        %   r: 
        %    description: Space point where is the node 
        %    class: double
        %    dimension: [1x3]
        % OptionalInputs:
        %   obj:
        %    description: node object
        %    class: node
        %    dimension: [1x1]
            if nargin == 0
                return
            end
            obj.r = r;
        end
        
        
    end
    methods (Static)
          function z = zeros(varargin)
        % description:    zeros(N) is an N-by-N matrix of zeros.
        %                 zeros(M,N) or zeros([M,N]) is an M-by-N matrix of zeros.
        %                 zeros(M,N,P,...) or zeros([M N P ...]) is an M-by-N-by-P-by-... array of
        %                 zeros.
        %                 zeros(SIZE(A)) is the same size as A and all zeros.
        %                 zeros with no arguments is the scalar 0.
        %                 zeros(..., CLASSNAME) is an array of zeros of class specified by the
        %                 string CLASSNAME.
        %                 zeros(..., 'like', Y) is an array of zeros with the same data type, sparsity,
        %                 and complexity (real or complex) as the numeric variable Y.
        % MandatoryInputs:   
        %   N: 
        %    description: Dimension
        %    class: integer
        %    dimension: [1x1]
        % Outputs:
        %    z:
        %       description: List of zeros 
        %       class: staris
        %       dimension: [1xN]
        
             if (nargin == 0)
                z = stairs;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = stairs.empty(varargin{:});
             else
             % Use property default values
                z = repmat(stairs,varargin{:});
             end
          end
       end
    
end

