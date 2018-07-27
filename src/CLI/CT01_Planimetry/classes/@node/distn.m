function result = distn(n1,n2,varargin)
%% DISTN
%   calculate the distance of two nodes. This method have two options 
%   'euclidean' mode  or 'manhattan' mode 
%    EXAMPLE
%    node1 = node([1 1])
%    See Also
%    vertex
% 

    %% Parameters 
    if coder.target('MATLAB')
        % matlab target
        p = inputParser;
        addRequired(p,'n1')
        addRequired(p,'n2')
        addOptional(p,'mode','euclidean',@mode_valid)
        parse(p,n1,n2,varargin{:})

        mode = p.Results.mode;
    else
        % simulink target
        mode = 'euclidean';
    end

    
    %% Init
    len1 = length(n1); len2 = length(n2);
    result = zeros(len1,len2);
    for i1 = 1:len1
       for i2 = 1:len2
           result(i1,i2) = distn1D(n1(i1),n2(i2),mode);
       end 
    end
    
end

function result =  distn1D(n1,n2,mode)
%% Function nodexnode 
    switch mode
        case 'euclidean'
            result = norm(n1.r-n2.r);
        case 'manhattan'
            result = ((n1.r(1)-n2.r(1))^2)^0.5 + ((n1.r(2)-n2.r(2))^2)^0.5;
    end
end
function boolean = mode_valid(mode)
    boolean= false;
    options = {"euclidean","manhattan"};
    if ~ischar(mode)
        error("The mode parameter must be char")
    elseif ~isa(mode,options)
        error("The mode parameter must be euclidean or manhattan")
    else 
        boolean= true;
    end
end