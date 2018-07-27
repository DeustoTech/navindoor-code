function result = timeline(iBFS)
%TIMELINE Summary of this function goes here
%   Detailed explanation goes here
    %% INPUT
    p = inputParser;
    addRequired(p,'iBFS',@iBFS_valid)
    
    parse(p,iBFS)
    %% 
    tf = round(index2time(iBFS,"end","end"),5);
    dt = round(iBFS.dt,5);
    result = 0:dt:tf;
end

function boolean = iBFS_valid(iBFS)
    boolean = false;
    if iBFS.dt == 0
       error('The object BeaconFreeSgn is damaged. Check out "dt" property.')
    else
        boolean = true;
    end
end

