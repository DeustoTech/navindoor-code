function result = hight2pressure(hight)
%HIGH2PRESURE 
   result = arrayfun(@(h) hight2pressure1D(h),hight);

end
function P = hight2pressure1D(hight)
%HIGH2PRESURE 
% - date: 09/05/2018
% - 
    %% R M g T0constans [1]
    R = 8.31432e3; % N m/(kmol K)
    g = 9.80665; % m/s
    M0 = 28.9644; % hg/kmol
    T0 = 288.15; % K    
    P0 = 760; % mmHg
    
    alpha = g*M0*hight/(R*T0);
    %% Formula [2]
    P = P0*exp(-alpha);
end
%% References 
% - https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4431287/#B17-sensors-15-07857
% - https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19770009539.pdf
