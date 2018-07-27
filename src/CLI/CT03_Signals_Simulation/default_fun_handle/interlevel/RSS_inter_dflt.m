function result = RSS_inter_dflt(x,y,h,ibeacon,index_connection,istraj,ibuild,parameters_sgn_interlevel)
%BARO_INTER_DFLT Summary of this function goes here
%   Detailed explanation goes here
  %%
    sigma = parameters_sgn_interlevel{1};
    hbeacon = ibeacon.height;

    distance = sqrt((x-ibeacon.r(1))^2 + (y-ibeacon.r(2))^2 + (h-hbeacon)^2);
    result = 10*log10(distance) + normrnd(0,sigma);

  %
end

