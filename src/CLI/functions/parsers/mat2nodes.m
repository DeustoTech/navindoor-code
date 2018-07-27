function nodes = mat2nodes(mat,varargin)
%MAT2NODES Summary of this function goes here
%   Detailed explanation goes here
    [lenrow, lencol] = size(mat); 

    p = inputParser;
    addRequired(p,"mat",@(mt) valid_mat(mt,lencol))
    addOptional(p,"class",'node',@valid_class)

    parse(p,mat,varargin{:})
    
    class = p.Results.class;
    
    nodes = zeros(1,lenrow,class);
   
    for nrow = 1:lenrow
        nodes(nrow).r = mat(nrow,:);
    end
end

function boolean = valid_mat(mat,lencol)
    boolean = false;
    if ~isnumeric(mat)
        error("the parameter mat must be a matrix [nx2]")
    elseif lencol ~=2 
        error("the parameter mat must be a matrix [nx2]")
    else 
        boolean = true;
    end 
end

function boolean = valid_class(class)
    boolean = false;
    options = {'node','beacon','elevator','stairs','door'};
    if ~ismember(class,options)
        error(strjoin(["The class only be: ",strjoin(options)]))
    else 
        boolean = true;
      
    end
end