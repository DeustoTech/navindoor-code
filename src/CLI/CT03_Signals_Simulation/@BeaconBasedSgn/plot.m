function plot(iBBS,varargin)
%PLO Summary of this function goes here
%   Detailed explanation goes here
    p = inputParser;
    addRequired(p,'iBBS');
    addOptional(p,'index',[],@index_valid)
    addOptional(p,'Parent',gcf)
    
    parse(p,iBBS,varargin{:})
    
    index = p.Results.index;
    Parent = p.Results.Parent;
    
    tables = signal2table(iBBS);

    number_subplots = length(tables.inlevel);
    if length(fieldnames(tables)) > 1
        number_subplots = number_subplots + length(tables.interlevel);
    end
    number_row_plots = round(0.5*(number_subplots + 1),5);
    
    switch iBBS.type
        case 'RSS'
            ylab = 'Attenuation (dB)';
        case 'ToF'
            ylab = 'Time of Flight (s)';
        case 'AoA'
            ylab = 'Angle of Arrive (radians)';
        
    end
    
    if number_row_plots == 1
        subplot(1,1,1,'Parent',Parent)
        plot(tables.inlevel{1}{:,1},tables.inlevel{1}{:,2:end})
        xlabel('time (s)')
        ylabel(ylab)
        title(['Level ',num2str(iBBS.BeaconBasedSgnLevels.level,'%.2d')])
        
        names = tables.inlevel{1}.Properties.VariableNames;
        names(1) = [];
        
        legend(replace(names,'_',' '),'Location','NorthEastOutside')
        return
    end
    %%
        
    for index = 1:number_row_plots - 1
        %% In level         
        subplot(number_row_plots,2,2*index-1,'Parent',Parent)
        table = tables.inlevel{index};
        plot(table{:,1},table{:,2:end})
        
        xlabel('time (s)')
        ylabel(ylab)
        title(['Level ',num2str(index,'%.2d')])
        
        names = table.Properties.VariableNames;
        names(1) = [];
        
        legend(replace(names,'_',' '),'Location','NorthEastOutside')
        %% Interlevel
        subplot(number_row_plots,2,2*index,'Parent',Parent )
        table = tables.interlevel{index};
        plot(table{:,1},table{:,2:end})  
        xlabel('time(s)')
        ylabel(ylab)

        title(['InterLevel ',num2str(index,'%.2d')])
        
        names = table.Properties.VariableNames;
        names(1) = [];
        
        legend(replace(names,'_',' '),'Location','NorthEastOutside')

    end
    index = index + 1;
    subplot(number_row_plots,2,2*index-1,'Parent',Parent)
    table = tables.inlevel{index};
    plot(table{:,1},table{:,2:end})
    title(['Level ',num2str(index,'%.2d')])   
    xlabel('time(s)')
    ylabel(ylab)
    
    names = table.Properties.VariableNames;
    names(1) = [];

    legend(replace(names,'_',' '),'Location','NorthEastOutside')

end

function boolean = index_valid(index)

boolean = false; 
if ~isnumeric(index)
    error('The parameter index must be numeric')
elseif round(index,6) ~= round(floor(index,6))
    error('The index ')
    
end



end
