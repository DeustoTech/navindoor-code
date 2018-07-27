function plot(iBFS,varargin)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

    p = inputParser;
    addRequired(p,'iBFS')
    addOptional(p,'Parent',gca)
    parse(p,varargin{:})
    
    Parent = p.Results.Parent;
    
    tline = timeline(iBFS);
    % pressure array
    pline = zeros(length(tline),iBFS.dim_signal);
    index = 0;
    for t=tline
       index = index + 1;
       result = step(iBFS,t);
       pline(index,:) = result.values;
    end
    subplot(1,1,1,'Parent',Parent)
    plot(tline',pline)
    xlabel('time (s)')

    switch iBFS.type
        case 'Baro'
            title('Evolution over time of pressure')
            ylabel('Pressure (mmHg)')
        case 'Magne'
            title('Evolution over time of orientation')
            ylabel('Angles (radiands)')
    end
end

