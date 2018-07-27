function result = timeline(istraj)
%TIMELINE Summary of this function goes here
%   Detailed explanation goes here
    %% INPUT
    p = inputParser;
    addRequired(p,'istraj',@istraj_valid)
    
    parse(p,istraj)
    %% 
    tf = round(index2time(istraj,"end","end"),5);
    dt = round(istraj.dt,5);
    result = 0:dt:tf;
end

function boolean = istraj_valid(istraj)
    boolean = false;
    if istraj.dt == 0
       error('The parameter istraj must have a velocity. Try use a velocity function to add velocity.')
    else
        boolean = true;
    end
 
end

