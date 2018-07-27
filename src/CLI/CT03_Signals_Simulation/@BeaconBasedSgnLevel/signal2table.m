function matrix = signal2table(iBBSLevel)
%RSS2MAT Summary of this function goes here
%   Detailed explanation goes here
    total_beacon = length(iBBSLevel.beacons);

    
    matrix = zeros(iBBSLevel.len,total_beacon);
    for index = 1:iBBSLevel.len
        col = iBBSLevel.ms(index).indexs_beacons;
        matrix(index,col) = iBBSLevel.ms(index).values;
    end
    
    timeline =(0:iBBSLevel.dt:iBBSLevel.ms(end).t)';
    labels = strcat('beacon_',num2str((0:length(iBBSLevel.beacons))','%0.3d')) ;
    labels(1,:) =   'time      ';
    matrix = array2table([timeline matrix],'VariableNames',cellstr(labels));
end