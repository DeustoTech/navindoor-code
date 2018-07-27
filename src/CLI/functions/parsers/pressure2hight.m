function hight = pressure2hight(P)
%HIGH2PRESURE 
% - date: 09/05/2018
% - 
    %% R M g T0constants [1] 
    R = 8.31432e3; % N m/(kmol K)
    g = 9.80665; % m/s
    M0 = 28.9644; % hg/kmol
    T0 = 288.15; % K
    
    P0 = 760;
    
    %% Formula [2]
    hight = ((R*T0)/(g*M0))*log(P0/P); 
end
%% References 
% - https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4431287/#B17-sensors-15-07857
% - https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19770009539.pdf
