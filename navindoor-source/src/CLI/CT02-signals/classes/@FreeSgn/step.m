function result = step(iFreeSgn,t)
%STEP Summary of this function goes here
%   Detailed explanation goes here
    indexs = 1:length(iFreeSgn.timeline);
    index = interp1(iFreeSgn.timeline,indexs,t,'previus','extrap');
    if isnan(index)
       error('The parameter t out range.') 
    end

    result.values = iFreeSgn.mss(index).values;

end
