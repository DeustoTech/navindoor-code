 classdef node < handle
    % description: Representacion de un punto 
    % visible: true
    properties 
        % type: "double"
        % default: "none"
        % description: This property is a array 1x3 that contains the [x y z].
        r       (1,3) double          = [0 0 0]  
        % type: "Functional"
        % default: "none"
        % description: This property contains the walls which this node is children.
        walls                                   
    end
    
    properties (Hidden)
        select  (1,1) logical         = false   % This property is used in navindoor GUI, indicate if the object is select or not 
    end
    
    methods
        %% Constructor & Settings
        function obj = node(r)
        % description: The node constructor need a array double of 3 dimension. 
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

        %% Arithmetic methods:  = - + *
        function result = eq(lobj2,lobj1) 
        % description: This method comprobe that the two nodes have the same r property
        % MandatoryInputs:   
        %   lobj2: 
        %       description: second node
        %       class: ControlParameterDependent
        %       dimension: [1xN]
        %   lobj1: 
        %       description: first node
        %       class: double
        %       dimension: [1xM]
        % Outputs:
        %   result:
        %       description: Boolean that indicate if lobj1==lobj2
        %       class: logical
        %       dimension: [NxM]       
            result = zeros(length(lobj1),length(lobj2),'logical');
            
            for ix=1:length(lobj1)
               for iy=1:length(lobj2)
                   result(ix,iy) = eq1(lobj1(ix),lobj2(iy));
               end
            end
        
        
            function r=eq1(obj1,obj2)
                if  obj1.r(1) == obj2.r(1) &&  obj1.r(2) == obj2.r(2)
                    r = true;
                else
                    r = false;
                end
            end
        end
        %%
        function result = minus(obj1,obj2)
        % description: This function solve a particular optimal control problem using
        %   the stochastic gradient descent algorithm. The restriction of the optimization 
        %   problem is a parameter-dependent finite dimensional linear system. Then, the 
        %   resulting states depend on a certain parameter. Therefore, the functional is
        %   constructed to control the average of the states with respect to this parameter.
        %   See Also in AverageClassicalGradient
        % autor: AnaN
        % MandatoryInputs:   
        %   iCPD: 
        %    description: Control Parameter Dependent Problem 
        %    class: ControlParameterDependent
        %    dimension: [1x1]
        %   xt: 
        %    description: The target vector where you want the system to go
        %    class: double
        %    dimension: [iCPD.Nx1]
        % OptionalInputs:
        %   tol:
        %    description: tolerance of algorithm, this number is compare with $J(k)-J(k-1)$
        %    class: double
        %    dimension: [1x1]
        %    default:   1e-5   
            fun=str2func(class(obj1));
            result = fun(obj1.r-obj2.r);
        end
        function result = plus(obj1,obj2)
        % description: This function solve a particular optimal control problem using
        %   the stochastic gradient descent algorithm. The restriction of the optimization 
        %   problem is a parameter-dependent finite dimensional linear system. Then, the 
        %   resulting states depend on a certain parameter. Therefore, the functional is
        %   constructed to control the average of the states with respect to this parameter.
        %   See Also in AverageClassicalGradient
        % autor: AnaN
        % MandatoryInputs:   
        %   iCPD: 
        %    description: Control Parameter Dependent Problem 
        %    class: ControlParameterDependent
        %    dimension: [1x1]
        %   xt: 
        %    description: The target vector where you want the system to go
        %    class: double
        %    dimension: [iCPD.Nx1]
        % OptionalInputs:
        %   tol:
        %    description: tolerance of algorithm, this number is compare with $J(k)-J(k-1)$
        %    class: double
        %    dimension: [1x1]
        %    default:   1e-5    
            fun=str2func(class(obj1));
            result = fun(obj1.r+obj2.r);
        end
        function result = times(obj1,obj2)
        % description: This function solve a particular optimal control problem using
        %   the stochastic gradient descent algorithm. The restriction of the optimization 
        %   problem is a parameter-dependent finite dimensional linear system. Then, the 
        %   resulting states depend on a certain parameter. Therefore, the functional is
        %   constructed to control the average of the states with respect to this parameter.
        %   See Also in AverageClassicalGradient
        % autor: AnaN
        % MandatoryInputs:   
        %   iCPD: 
        %    description: Control Parameter Dependent Problem 
        %    class: ControlParameterDependent
        %    dimension: [1x1]
        %   xt: 
        %    description: The target vector where you want the system to go
        %    class: double
        %    dimension: [iCPD.Nx1]
        % OptionalInputs:
        %   tol:
        %    description: tolerance of algorithm, this number is compare with $J(k)-J(k-1)$
        %    class: double
        %    dimension: [1x1]
        %    default:   1e-5
            if isa(obj1,'double')
                number = obj1;
                obj = obj2;
            elseif isa(obj2,'double')
                number = obj2;
                obj = obj1;
            else 
                error('Must be node*numeric')
            end
            fun=str2func(class(obj));
            result = arrayfun(@(x)fun(x.r*number),obj);
            %result = fun(obj.r*number);
        end
    end  
  %% Zeros constructor 

    methods (Static)
          function z = zeros(varargin)
            % description: This function solve a particular optimal control problem using
            %   the stochastic gradient descent algorithm. The restriction of the optimization 
            %   problem is a parameter-dependent finite dimensional linear system. Then, the 
            %   resulting states depend on a certain parameter. Therefore, the functional is
            %   constructed to control the average of the states with respect to this parameter.
            %   See Also in AverageClassicalGradient
            % autor: AnaN
            % MandatoryInputs:   
            %   iCPD: 
            %    description: Control Parameter Dependent Problem 
            %    class: ControlParameterDependent
            %    dimension: [1x1]
            %   xt: 
            %    description: The target vector where you want the system to go
            %    class: double
            %    dimension: [iCPD.Nx1]
            % OptionalInputs:
            %   tol:
            %    description: tolerance of algorithm, this number is compare with $J(k)-J(k-1)$
            %    class: double
            %    dimension: [1x1]
            %    default:   1e-5
            %   beta:
            %    description: This number is the power of the control, is define by follow expresion $$J = \\min_{u \\in L^2(0,T)} \\frac{1}{2} \\left[ \\frac{1}{|\\mathcal{K}|} \\sum_{\\nu \\in \\mathcal{K}} x \\left( T, \\nu \\right) - \\bar{x} \\right]^2  + \\frac{\\beta}{2} \\int_0^T u^2 \\mathrm{d}t, \\quad \\beta \\in \\mathbb{R}^+ $$ 
            %    class: double
            %    dimension: [1x1]
            %    default:   1e-1
            %   MaxIter:
            %    description: Maximun of iterations of this method
            %    class: double
            %    dimension: [1x1]
            %    default:   100
             if (nargin == 0)
                z = node;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = node.empty(varargin{:});
             else
             % Use property default values
                z = repmat(node,varargin{:});
             end
          end
       end

end
