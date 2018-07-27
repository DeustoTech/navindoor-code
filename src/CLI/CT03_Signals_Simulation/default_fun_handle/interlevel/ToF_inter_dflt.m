function result = ToF_inter_dflt(x,y,h,ibeacon,index_connection,istraj,ibuild,parameters_sgn_interlevel)
%BARO_INTER_DFLT Summary of this function goes here
%   Detailed explanation goes here
  %%
    c = 3e8;
  
    sigma = parameters_sgn_interlevel{1};
    hbeacon = ibeacon.height;

    distance = sqrt((x-ibeacon.r(1))^2 + (y-ibeacon.r(2))^2 + (h-hbeacon)^2);
    result = distance/c + normrnd(0,sigma);

  %
end

