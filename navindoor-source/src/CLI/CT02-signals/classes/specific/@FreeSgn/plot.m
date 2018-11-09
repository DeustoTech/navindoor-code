function plot(iFreeSignal,varargin)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

p = inputParser;
addRequired(p,'iFreeSignal')
addOptional(p,'Parent',gcf)

parse(p,iFreeSignal,varargin{:})

Parent = p.Results.Parent;

ax = axes('Parent',Parent);
switch iFreeSignal.type
    case 'Barometer'
        result = arrayfun(@(t) step(iFreeSignal,t),iFreeSignal.timeline);
        line(iFreeSignal.timeline,[result.values],'Parent',ax,'Marker','.','LineStyle','-')
        ax.Title.String = 'Evolution over time of pressure';
        ax.YLabel.String = 'Pressure (mmHg)';
        ax.XLabel.String = 'time(s)';
        ax.FontSize = 12;
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        
    case 'InertialFoot'
        result = arrayfun(@(t) step(iFreeSignal,t),iFreeSignal.timeline);
        mt = [result.values]';
        %
        ylabels = {'ax','ay','az','Gx','Gy','Gz'};
        for index = 1:6
            ax = subplot(2,3,index,'Parent',Parent);
            line(iFreeSignal.timeline,mt(:,index))
            ax.XLabel.String = 'time(s)';
            ax.YLabel.String = ylabels{index};

        end


        
end

