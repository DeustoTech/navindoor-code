function matrix = signal2table(iBFSLevel)
%RSS2MAT Summary of this function goes here
%   Detailed explanation goes here
    dim = length(iBFSLevel.ms(1));
    matrix = zeros(iBFSLevel.len,dim);
    for index = 1:iBFSLevel.len
        matrix(index,:) = iBFSLevel.ms(index).values;
    end
    
    timeline =(0:iBFSLevel.dt:iBFSLevel.ms(end).t)';
    labels = strcat('x_',num2str((0:dim)','%0.3d')) ;
    labels(1,:) =   'time ';
    matrix = array2table([timeline matrix],'VariableNames',cellstr(labels));
end