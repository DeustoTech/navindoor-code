function line3(nodes,varargin)
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
    mt = vec2mat([nodes.r],3);
    
    boolean = arrayfun(@(index) strcmp(varargin{index},'Parent'),1:length(varargin));
    [~,index] = ismember(1,boolean);
    Parent = varargin{index+1};
    
    i = 0;
    for inode = nodes
        i = i + 1;
            switch class(inode)
                case 'elevator'
                        text(mt(i,1)+1,mt(i,2),mt(i,3),['ele-',num2str(i)],'FontSize',10,'Parent',Parent);
                case 'stairs'
                        text(mt(i,1)+1,mt(i,2),mt(i,3),['sta-',num2str(i)],'FontSize',10,'Parent',Parent);
                case 'beacon'
                        text(mt(i,1)+1,mt(i,2),mt(i,3),['L',num2str(inode.level),'-AP-',num2str(i)],'FontSize',10,'Parent',Parent);

            end
            line(inode.r(1),inode.r(2),inode.r(3),varargin{:})
            
        if inode.select
            line(inode.r(1),inode.r(2),inode.r(3),varargin{:},'Marker','o','MarkerSize',15,'MarkerFaceColor','none','MarkerEdgeColor','red','LineWidth',1)
        end
    end
end

