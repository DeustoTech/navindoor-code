function result = AoA_inter_dflt(x,y,h,ibeacon,index_connection,istraj,ibuild,parameters_sgn_interlevel)
%BARO_INTER_DFLT Summary of this function goes here
%   Detailed explanation goes here
  %%
    sigma = parameters_sgn_interlevel{1};

    result = normrnd(0,sigma);
    
  %
end

