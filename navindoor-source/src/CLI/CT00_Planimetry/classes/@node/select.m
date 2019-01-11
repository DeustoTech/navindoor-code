function result = select(nodes,r,varargin)
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
   p = inputParser;

   addRequired(p,'nodes')
   addRequired(p,'r')
   addOptional(p,'precision',2.0)
   
   parse(p,nodes,r,varargin{:})
   
   precision = p.Results.precision;
   
   distances = arrayfun(@(inode) norm(inode.r(1:2) - r(1:2)),nodes);
   [min_value, index_min] = min(distances);
   
   if precision >= min_value
       result = index_min;
       nodes(index_min).select = ~nodes(index_min).select;
   end
   
end

