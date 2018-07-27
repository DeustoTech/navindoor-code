function animation(istrajs,ibuild,varargin)
    %% Input vars
    p = inputParser;
    addRequired(p,'istrajs')
    addRequired(p,'ibuild')
    
    addOptional(p,'axtraj',false)
    addOptional(p,'axvelo',false)
    addOptional(p,'axlevel',false)
    addOptional(p,'xx',1.0)

    
    parse(p,istrajs,ibuild,varargin{:});
    
    axtraj  = p.Results.axtraj;
    axvelo  = p.Results.axvelo;
    axlevel = p.Results.axlevel;
    xx      = p.Results.xx;
    
    if islogical(axtraj)
        f1=figure;
        f1.Units = 'normalize';
        f1.Position = [ 0.04 0.25 0.86 0.6 ];
        axtraj = axes;        
        f1.ToolBar = 'none';
        f1.MenuBar = 'none';
        f1.Name = 'Trajectory Animation';
        f1.NumberTitle = 'off';
        daspect(axtraj,[1 1 1])
    end
    
    if islogical(axvelo)
        f2=figure;
        f2.Units = 'normalize';
        f2.Position = [ 0.04 0.05 0.86 0.15 ];
        f2.ToolBar = 'none';
        f2.MenuBar = 'none';
        axvelo = axes;  
        axvelo.YLimMode = 'manual';
        f2.Name = 'Velocity Animation';
        f2.NumberTitle = 'off';

    end

    if islogical(axlevel)
        f3=figure;
        f3.Units = 'normalize';
        f3.Position = [ 0.9 0.05 0.075 0.8 ];
        f3.ToolBar = 'none';
        f3.MenuBar = 'none';
        axlevel = axes('Units','normalized','Position',[0 0 1 1]);   
        
        f3.Name = 'Levels';
        f3.NumberTitle = 'off';
    end
    %% Init Code
    
    % title axes
    
    axvelo.Title.String = 'Velocity';
    axvelo.YLabel.String = 'v[m/s]';
    axvelo.XLabel.String = 't[s]';
    
    axtraj.Title.String = 'Level';
    axtraj.XLabel.String = 'x[m]';
    axtraj.YLabel.String = 'y[m]';
    
    
    % Global paremeter 
    len_strajs = length(istrajs);
    line_traj = repmat(line,1,len_strajs);

    it_before = 1;
    
    update_level(it_before)
    
    update_all_traj(istrajs,0);
    tic;
    %% main bucle
    while true
        t = xx*toc; % xx play speed 
        pause(0.05)
        try
           result = time2index(istrajs(1),t);
        catch 
           return 
        end
        
        if ~result.interlevel 
            delete(line_traj)
            update_all_traj(istrajs,t);
        else  
            if result.index_trajs ~= it_before + 1
                update_level(result.index_trajs + 1)
                it_before = result.index_trajs - 1;
            end
        end 
    end
    %% UDATE ALL TRAJ
    function update_all_traj(istrajs,t)
        for iter=1:len_strajs
            if iter == 1
                color = [1 0 0.5]; 
            elseif iter == 2
                color = [0 1 0.5];
            elseif iter == 3
                color = [1 1 0.5];
            end
            result = time2index(istrajs(iter),t);
            line_traj(iter) = update_traj(result,istrajs(iter),color);
        end
    end
    %% UPDATE LEVEL
    function update_level(index_trajs)       
        ilevel = ibuild.levels(istrajs(1).trajs(index_trajs).level+1);
        delete(axtraj.Children)
        delete(axvelo.Children)
        delete(axlevel.Children)

        line(ilevel,'Parent',axtraj);
        axtraj.XLim = [ 0 ilevel.dimensions(1)];
        axtraj.YLim = [ 0 ilevel.dimensions(2)];

        level_box(istrajs(1).trajs(index_trajs).level);
        
        for index_supertrajs= 1:len_strajs
            itraj  = istrajs(index_supertrajs).trajs(index_trajs);
            if index_supertrajs == 1
                color = [1.0 0 0.75]; 
                axvelo.YLim = [0.8*min(itraj.v) 1.2*max(itraj.v)];
            elseif index_supertrajs == 2
                color = [0.0 1 0.75];
            elseif index_supertrajs == 3
                color = [1 1 0.5];
            end
            plot(itraj,'Parent',axtraj,'Color',color,'LineStyle','--');
            line(itraj.t,itraj.v,'Parent',axvelo,'Color',color,'LineStyle','--');
        end
        axtraj.Title.String = ['Level ',num2str(ilevel.n,'%.2d')];
    end
    %% UPDATE TRAJ and VELOCITY
    function line_traj = update_traj(result,istraj,color)
        LineWidth = 3;
        size_line = 6;
        general_options = {'LineWidth',LineWidth,'Marker','.','LineStyle','-','MarkerSize',20};
        if ~result.interlevel 
            itraj = istraj.trajs(result.index_trajs);
            if result.index_nodes > size_line
                line_traj = line(itraj.nodes(result.index_nodes-size_line:result.index_nodes), ...
                    'Color',color,'Parent',axtraj,general_options{:},'MarkerFaceColor',color);
                
                line(itraj.t(result.index_nodes-size_line:result.index_nodes), ...
                     itraj.v(result.index_nodes-size_line:result.index_nodes), ...
                     'Color',color,'Parent',axvelo,'LineWidth',LineWidth);
            else
                line_traj = line(itraj.nodes(1:result.index_nodes),...
                    'Color',color,'Parent',axtraj,general_options{:},'MarkerFaceColor',color);
                
                line(itraj.t(1:result.index_nodes),itraj.v(1:result.index_nodes), ...
                    'Color',color,'Parent',axvelo,'LineWidth',LineWidth);
            end
        else
            table_txyh = istraj.dt_connections{result.index_trajs};
            if result.index_nodes > size_line
                line_traj = line(table_txyh.x(result.index_nodes-size_line:result.index_nodes) ...
                    ,table_txyh.x(result.index_nodes-size_line:result.index_nodes),...
                    'Color',color,'Parent',axtraj,general_options{:},'MarkerFaceColor',color);
            else
                line_traj = line(table_txyh.x(1:result.index_nodes) ...
                    ,table_txyh.x(1:result.index_nodes),...
                    'Color',color,'Parent',axtraj,general_options{:},'MarkerFaceColor',color);
            end
        end
    end
    function level_box(n)
        intery = (100/length(ibuild.levels));
        rectangle('Position',[0 n*intery 1 intery],'Curvature',0.4,'FaceColor',[0 .5 .5],'Parent', axlevel);   
        for i=1:length(ibuild.levels)
            ydata = intery*i;
            line([0,1],[ydata,ydata],'Color','black','LineStyle','-','Parent', axlevel);
            text(0.375,ydata-0.5*intery,[' ',num2str(i-1)],'FontSize',20,'Parent', axlevel);
        end    

        rectangle('Position',[0 0 1 100],'Curvature',0.4,'LineWidth',3,'Parent', axlevel);

        axlevel.XLim = [0 1];
        axlevel.YLim = [0 100];
        axlevel.Visible ='off';
    end
end

