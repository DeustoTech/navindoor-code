function points = mat2points(mat)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [nrow, ~] = size(mat);
    
    points = zeros(1,nrow,'point');
    for index_row =1:nrow
        points(index_row) = point(mat(index_row,:));
    end
end

