function mustBeDiff(nodes)
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

    mat         = vec2mat([nodes.r],3);
    mat_unique  = unique(mat,'rows');
    
    if  (length(mat(:,1)) ~= length(mat_unique(:,1)))
        error('The nodes must be different')
    end
end

