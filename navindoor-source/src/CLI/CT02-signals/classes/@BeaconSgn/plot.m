function plot(iBeaconSgn,varargin)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

    p = inputParser;
    addRequired(p,'iBeaconSgn')
    addOptional(p,'Parent',gcf)

    parse(p,iBeaconSgn,varargin{:})

    Parent = p.Results.Parent;


    result = arrayfun(@(t) step(iBeaconSgn,t),iBeaconSgn.timeline);

    ax = axes('Parent',Parent);
    
    ax.XLabel.String = 'time(s)';

    switch iBeaconSgn.type
        case  'RSS'
            ax.YLabel.String = 'Attenuation(dB)';
        case 'ToF'
            ax.YLabel.String = 'Time of Flight(s)';
        case 'AoA'
            ax.YLabel.String = 'Angle(radians)';
    end
    
    ln = line(iBeaconSgn.timeline,[result.values]','Parent',ax,'Marker','.','LineStyle','-');
    
    nb = length(iBeaconSgn.beacons);
    
    
    ilevel = iBeaconSgn.beacons(1).level;
    iter = 0;
    
    legend_text = {};
    i = 1;
    for ibeacon = iBeaconSgn.beacons
        iter = iter + 1;
        if ilevel ~= ibeacon.level
            iter = 1;
            ilevel = ibeacon.level;
        end
        legend_text{i} = ['L',num2str(ibeacon.level),'AP',num2str(iter)];
        i = i + 1;
        
    end
    legend(legend_text,'Location','NorthEastOutside')
end

