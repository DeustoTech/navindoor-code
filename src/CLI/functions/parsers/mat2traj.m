function otraj=mat2traj(mat)

    %% Assignment entry vars
    p = inputParser;
    addRequired(p,'mat',@mat_valid);
    parse(p,mat);
    %% Init
    
    [len ,ncol ]= size(mat(:,1));
    nodes = zeros(1,len,'vertex');
    for index=1:len
        nodes(index) = vertex(mat(index,1:2));
    end
    otraj = traj(nodes);
    
    % add velocity if exist.
    if ncol == 4
        otraj.v = sqrt(mat(:,3).^2 +  mat(:,4).^2 );
        otraj.t = mat(:,5);
    end
end

function boolean = mat_valid(mat)
    boolean = false; 
    [~,ncol] = size(mat);
    if ~(ncol == 2||ncol==5)
        error('The entry matrix only can have a 2 or 5 columns. When the columns number is 2 the format is [x y], and when is 5 the format is [x y vx vy t]')
    else
        boolean = true;
    end
end