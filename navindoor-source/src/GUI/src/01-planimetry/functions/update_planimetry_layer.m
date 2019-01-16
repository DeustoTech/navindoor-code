function update_planimetry_layer(h,varargin)
%UPDATE_PLANIMETRY_LAYER Summary of this function goes here
%   Detailed explanation goes here
% Control of parameters 
    p = inputParser;
    addRequired(p,'h')
    addOptional(p,'auto_zoom',false)
    addOptional(p,'replot',true)
    addOptional(p,'onlyclickaxes',false)
    addOptional(p,'mode',[])
    addOptional(p,'option',[])
    
    parse(p,h,varargin{:})

    auto_zoom = p.Results.auto_zoom;
    replot = p.Results.replot;
    onlyclickaxes =  p.Results.onlyclickaxes;
    mode =  p.Results.mode;
    option =  p.Results.option;

% 
    %tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
    
    %% Levels Panel 
    %level_panel = findobj(tab_planimetry,'Title','Levels');
    % 
    %boxlevels = findobj(level_panel,'Style','listbox');
    boxlevels = h.iur_figure.Children(1).Children(1).Children(2).Children(3).Children(6);
    index_level = boxlevels.Value;

    if ~onlyclickaxes

        number_of_levels = length(h.planimetry_layer);

        if index_level > number_of_levels
            boxlevels.Value  = number_of_levels;
        end

        boxlevels.String = num2str((0:number_of_levels-1)');


    %% PNG File Panel

        %%% pngfile_panel = findobj(tab_planimetry,'Title','PNG File');

        %%% checkbox_view = findobj(pngfile_panel,'Style','checkbox');
        checkbox_view = h.iur_figure.Children(1).Children(1).Children(2).Children(2).Children(2);
        checkbox_view.Value = h.planimetry_layer(index_level).showfigure;

        %%% edit_path = findobj(pngfile_panel,'Style','edit');
        edit_path = h.iur_figure.Children(1).Children(1).Children(2).Children(2).Children(5);
        edit_path.String = h.planimetry_layer(index_level).pngfile;
    %% Dimension Panel
        
        %%% Dimension_panel = findobj(tab_planimetry,'Title','Dimension');

        
        %%% xlim = findobj(Dimension_panel,'Tag','xlim');
        xlim = h.iur_figure.Children(1).Children(1).Children(2).Children(1).Children(9);
        xlim.String = num2str(h.planimetry_layer(index_level).XLim(2));

        %%% ylim = findobj(Dimension_panel,'Tag','ylim');
        ylim = h.iur_figure.Children(1).Children(1).Children(2).Children(1).Children(7);
        ylim.String = num2str(h.planimetry_layer(index_level).YLim(2));

        %% Other Options Panel
        
        %%% other_panel = findobj(tab_planimetry,'Title','Levels');
        %%% edit_hieght = findobj(other_panel,'Style','edit');
        edit_hieght = h.iur_figure.Children(1).Children(1).Children(2).Children(3).Children(2);
        edit_hieght.String = num2str(h.planimetry_layer(index_level).height);
    
    end
    
    %% Graph Panel

    %%% graph_panel = findobj_figure(tab_planimetry,'Graphs');
    %%% axes_planimetry = graph_panel.Children;
    axes_planimetry = h.iur_figure.Children(1).Children(1).Children(1).Children;
    if strcmp(option,'insert')
        replot = false;
    end
    
    plot(h.planimetry_layer,index_level,axes_planimetry,'replot',replot,'mode',mode,'option',option);


    if auto_zoom
        axes_planimetry.XLim = [0 str2double(xlim.String)];
        axes_planimetry.YLim = [0 str2double(ylim.String)];
    end
end

