function result = timeline(iBBS)
%TIMELINE Summary of this function goes here
%   Detailed explanation goes here
    %% INPUT
    p = inputParser;
    addRequired(p,'iBFS',@iBFS_valid)
    
    parse(p,iBBS)
    %% 
    tf = round(index2time(iBBS,"end","end"),5);
    dt = round(iBBS.dt,5);
    result = 0:dt:tf;
end

function boolean = iBFS_valid(iBFS)
    boolean = false;
    if iBFS.dt == 0
       error('The object BeaconBasedSgn is damaged. Check out "dt" property.')
    else
        boolean = true;
    end
end

