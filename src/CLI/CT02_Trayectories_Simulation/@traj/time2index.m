function index_traj = time2index(itraj,t)
%STEP Summary of this function goes here
%   Detailed explanation goes here
   [ ~ ,index_traj ] = min(abs(itraj.t - t)); 
   
end

