function result = signal2table(BBS)
%SIGNAL2TABLE Summary of this function goes here
%   Detailed explanation goes here
    index  = 0;
        
    for BBSL = BBS.BeaconBasedSgnLevels
        index = index + 1;
        inlevel{index} = signal2table(BBSL);
        if index ~= length(BBS.BeaconBasedSgnLevels)
            intersignal = BBS.intersignal{index};
            beacons = [BBS.BeaconBasedSgnLevels(index).beacons BBS.BeaconBasedSgnLevels(index+1).beacons];
            
            len = length(BBS.intersignal{index});
            matrix = zeros(len,length(beacons));
            for index_ms = 1:len
               col =  intersignal(index_ms).indexs_beacons;
               matrix(index_ms,col) = intersignal(index_ms).values;
            end
            timeline = [intersignal.t]';
            labels = strcat('beacon_',num2str((0:length(beacons))','%0.3d'));
            labels(1,:) =   'time      ';
            matrix = array2table([timeline matrix],'VariableNames',cellstr(labels));
            interlevel{index} = matrix;
        end
    end
    
    result.inlevel    = inlevel;
    if length(BBS.BeaconBasedSgnLevels) > 1
        result.interlevel = interlevel;
    end
end

