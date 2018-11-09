function walls = DeleteSelect(walls)
%DELETE Summary of this function goes here
%   Detailed explanation goes here

    num_eliminados = 0;
    len = length(walls);
    for index = 1:len 
        iwall = walls(index - num_eliminados);
        if isvalid(iwall)
            if iwall.select
               delete(iwall) 
               walls(index - num_eliminados) = [];
              num_eliminados = num_eliminados + 1;
            end
        else
           walls(index - num_eliminados) = [];
           num_eliminados = num_eliminados + 1;
        end
    end 
    
end

