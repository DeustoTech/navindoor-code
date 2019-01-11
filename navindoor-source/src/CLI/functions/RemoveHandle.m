function list = RemoveHandle(list)
%REMOVEHANDLE Summary of this function goes here
%   Detailed explanation goes here
    num_del = 0;
    for index = 1:length(list)
        if ~isvalid(list(index-num_del))
            list(index) = [];
            num_del = num_del + 1;
        end
    end 

end

