function animation(itraj,ilevel,varargin)
    %% ANIMATION 
   
     %% Basic Example 
    %{
        clear;
        %
        % creamos una trayectoria 
        %
        x = 1:0.1:10;
        y = (x).^2;
        itraj = mat2traj([x' y'])
        %
        % Añadimos velocidad con los valores por defecto
        %
        itraj = velocity(itraj)
        %
        animation(itraj) 
        %
    %}  
    %% Input vars
    p = inputParser;
    addRequired(p,'itraj')
    addRequired(p,'ilevel')
    
    addOptional(p,'axtraj',false)
    addOptional(p,'axvelo',false)
    addOptional(p,'axlevel',false)
    
    parse(p,itraj,ilevel,varargin{:});
    
    axtraj  = p.Results.axtraj;
    axvelo  = p.Results.axvelo;
    axlevel = p.Results.axlevel;
    
    if islogical(axtraj)
        f1=figure;
        f1.Units = 'normalize';
        f1.Position = [ 0.04 0.15 0.35 0.35 ];
        axtraj = axes;        
    end
    
    if islogical(axvelo)
        f2=figure;
        f2.Units = 'normalize';
        f2.Position = [ 0.40 0.15 0.35 0.35 ];
        axvelo = axes;         
    end

    if islogical(axlevel)
        f3=figure;
        f3.Units = 'normalize';
        f3.Position = [ 0.76 0.15 0.15 0.35 ];
        axlevel = axes;          
    end
    
    figani=gcf;
   
 
    % memory allocation 
    list_nodes  = zeros(1,1000,'vertex');
    tlist = zeros(1,1000);
    vlist = zeros(1,1000);

    inode = x2vertex(itraj(1),0);

    % init axes trajectory

    line(ilevel,'Parent', axtraj) 
    axtraj.XLim = [0 ilevel.dimensions(1)];
    axtraj.YLim = [0 ilevel.dimensions(2)];

    plot(itraj,'LineStyle','--','Color','cyan','Parent', axtraj)

    % init axes v(t)
    plot(itraj.t,itraj.v,'Color','cyan','LineStyle','--','Parent', axvelo) 
    xlabel(axvelo,'time(s)')
    ylabel(axvelo,'velocity (m/s)')



    intery = (100/length(1));
    rectangle('Position',[0 inode.level*intery 1 intery],'Curvature',0.4,'FaceColor',[0 .5 .5],'Parent', axlevel)      
    for i=1:length(1)
        ydata = intery*i;
        line([0,1],[ydata,ydata],'Color','black','LineStyle','-','Parent', axlevel)
        text(0.45,ydata-0.5*intery,num2str(i-1),'FontSize',20,'Parent', axlevel)
    end    

    rectangle('Position',[0 0 1 100],'Curvature',0.4,'LineWidth',3,'Parent', axlevel)

    axlevel.XLim = [0 1];
    axlevel.YLim = [0 100];
    axlevel.Visible ='off';
    index = 0;

    t = 0;
    tic
    lmt = line;
    while t < itraj.t(end)
        index = index + 1;

        t = toc;
        x = interp1(itraj.t,itraj.x,t);
        inode=x2vertex(itraj,x);
        list_nodes(index) =  inode;
        if index > 10
            mt = vec2mat([list_nodes(index-10:index).r],2);
        else
            mt = vec2mat([list_nodes(1:index).r],2);
        end
        delete(lmt);
        lmt = line(mt(:,1),mt(:,2),'Color','red','Parent', axtraj,'LineWidth',3) ;

        title(['t = ',num2str(toc,'%.2f'),'s'],'Parent', axtraj)

        vlist(index) = interp1(itraj.t,itraj.v,t);
        tlist(index) = t;

        line(tlist(1:index),vlist(1:index),'Color','blue','LineStyle','-','Parent', axvelo) 
        title(['v = ',num2str(vlist(index),'%.2f'),'m/s'],'Parent', axvelo);
        pause(0.01)
        if ~isvalid(figani)
             return
        end

    end

end
