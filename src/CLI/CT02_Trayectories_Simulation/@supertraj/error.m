function mt_error = error(strajs)
%ERROR Summary of this function goes here
%   Detailed explanation goes here

    lenst = length(strajs);
    
    p = inputParser;
    addRequired(p,'strajs',@strajs_valid)
        
    mt = {};
    index_straj = 0;
    for istraj = strajs
       index_straj = index_straj + 1;
       mt{index_straj} = supertraj2mat(istraj);
       mt{index_straj} = mt{index_straj}(:,1:2);
    end
    
    mt_error = zeros(length(mt{1}(:,1)),length(strajs)-1);
    
    for index_straj = 2:lenst
        mt_error(:,index_straj-1) = ...
            sqrt((mt{1}(:,1) - mt{index_straj}(:,1)).^2 + (mt{1}(:,2) - mt{index_straj}(:,2)).^2);
    end
    
    function boolean = strajs_valid(~)
        boolean = false;
        if lenst < 2
            error('The patrameter strajs must have at least two trajs.')
        else
           boolean = true; 
        end
    end
end

