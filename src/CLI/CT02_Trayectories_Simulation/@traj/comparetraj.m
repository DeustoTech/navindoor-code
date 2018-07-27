function comparetraj(itrajs,varargin)
%% COMPARE 
% anaimations of trajs list
%
% SYNTAX
% ------
% comparetraj([itraj1 itraj2 itraj3 ...],'level',ilevel)
%
% INPUTS:
% ------
%   - itrajs (mandatory) _________: list of trayectories
%   - 'level',ilevel(optional) ___: level 
%
% OUTPUTS:
% -------
%   - Nothing, only plot    
%
% EXAMPLE
% -------
% % creamos una trayectoria 
%
%   x = 1:0.1:10;
%   y = (x).^0.5;
%   itraj1 = mat2traj([x' y']);
%   itraj1 = velocity(itraj1);
%   x = 1:0.1:10;
%   y = (x).^0.5 + normrnd(0,5,[1 91]);
%   itraj2 = mat2traj([x' y']);
%   itraj2 = velocity(itraj2);
%   
%   comparetraj([itraj1 itraj2])
%
% 

    %% Optional Parameters 
    % =============================================================

    if (nargin-1)/2 ~= round((nargin-1)/2)
        error('options must be write in pairs')
    end
    

    %% Parameters Asigment
    % =============================================================
    options  = {'axes','level'};

    if nargin > 1
        for index = 2:2:nargin-1
           if ismember(varargin{index-1},options)
                name_var = varargin{index-1};
                value_var = varargin{index};
                switch name_var
                    case 'level'
                        ilevel = value_var;
                    case 'axes'
                        axes = value_var;
                end
           else 
               error([varargin{index-1},' is not a option of signal'])
           end
        end
    end           
    
    axes = cla;
    axes.NextPlot = 'add';
    

    len_trajs = length(itrajs);
    
    %% Static 
    color_list = {'r','g','b','y','m','c','k'};
    for index = 1:len_trajs
        xdat = itrajs(index).mt(:,1);
        ydat = itrajs(index).mt(:,2);
        line('LineStyle','--','Parent',axes,'XData',xdat,'YData',ydat,'Color',color_list{mod(index,7) + 1}) ;
    end
    if ~isempty([itrajs.label])
        legend({itrajs.label},'AutoUpdate','off')
    end
     if exist('ilevel','var')     
        plot(ilevel)
    end   
    
    %% Dynamic 
    for index = 1:len_trajs
        xdat = itrajs(index).mt(1,1);
        ydat = itrajs(index).mt(1,2);
        line('LineStyle','-','Parent',axes,'XData',xdat,'YData',ydat,'Color',color_list{mod(index,7) + 1}) 
    end
    
    for index = 1:len_trajs
        xdat = itrajs(index).mt(1,1);
        ydat = itrajs(index).mt(1,2);
        line('Marker','*','Parent',axes,'XData',xdat,'YData',ydat,'Color',color_list{mod(index,7) + 1}) 
    end
    
    
    dt = itrajs(1).t(2) - itrajs(1).t(1);
    for index_time = 2:itrajs(1).len
        for index_traj = 1:len_trajs
            xdat = itrajs(index_traj).mt(1:index_time,1);
            ydat = itrajs(index_traj).mt(1:index_time,2);
            
            point_xdata = xdat(end);
            point_ydata = ydat(end);
            
            axes.Children(len_trajs-index_traj+1).XData = point_xdata;
            axes.Children(len_trajs-index_traj+1).YData = point_ydata;
            
            axes.Children(2*len_trajs-index_traj+1).XData = xdat;
            axes.Children(2*len_trajs-index_traj+1).YData = ydat;
        end
        pause(dt);
    end

    
end

