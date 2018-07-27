function mat = supertraj2mat(istraj)
%SUPERTRAJ2MAT Summary of this function goes here
%   Detailed explanation goes here
    tline = timeline(istraj);
    mat = zeros(length(tline),6);
    
    index = 0;
    for t=tline
       index = index + 1;
       result = step(istraj,t,'velocity',true,'hight',true);
       mat(index,:) = [result.x result.y result.h result.vx result.vy t];
    end
end

