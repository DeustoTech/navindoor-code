function ms_nodes = Baro_inter_dflt(index_connection,istraj,ibuild,parameters)
%BARO_INTER_DFLT Summary of this function goes here
%   Detailed explanation goes here
  % 
  %% Parameters
  sigma = parameters{1};
  %%
  
  tline = istraj.dt_connections{index_connection}.t;
  hline = istraj.dt_connections{index_connection}.h;
  
  pline = hight2pressure(hline) + normrnd(0,sigma,[length(tline),1]);         % Initial pressure
  
  
  
  P_matrix = array2table([tline , pline],'VariableNames',{'time ','hight'});
  
  sz = size(P_matrix); 
  ms_nodes = zeros(sz(1),1,'ms_node');
  for nrow = 1:sz(1)
       ms_nodes(nrow).t = P_matrix{nrow,1};
       ms_nodes(nrow).values = P_matrix{nrow,2:end};
       ms_nodes(nrow).indexs_beacons = 1:length(ms_nodes(nrow).values);  
  end
  %
end

