function straj = velocity(straj,ibuild,varargin)
%VELOCITY Summary of this function goes here
%   Detailed explanation goes here
    

    index_build = find(strcmp(varargin,'waitbar') );
    if ~isempty(index_build)
        waitbar_boolean = varargin{index_build + 1};
        varargin(index_build) = [];
        varargin(index_build) = [];
    else
        waitbar_boolean = false;
    end

    %% Init
    if straj.len > 1
        straj.dt_connections = {zeros(straj.len-1)};
    end
    
     if waitbar_boolean
           f = waitbar(0,'0 %','Name','Add Velocity');
    end   
    
    for index_trajs = 1:straj.len

        straj.trajs(index_trajs) = velocity(straj.trajs(index_trajs),varargin{:});
        %% 
        if index_trajs ~= straj.len
            % will comprobate that these nodes are elevtors or staris class.
            iclass  = class(straj.connections(index_trajs).nodes);
            switch iclass
                case 'elevator'
                    mu    = 10; % mean time by elevator
                    sigma = 1;

                case 'stairs' 
                    mu    = 30; % mean time by stairs
                    sigma = 1;                   
            end
            tf = normrnd(mu,sigma);
            
            dt = straj.trajs(index_trajs).dt;
            
            ni = straj.trajs(index_trajs).level;
            nf = straj.trajs(index_trajs + 1).level;
            
            hi = ibuild.levels(ni + 1).high;
            hf = ibuild.levels(nf + 1).high;
            
            xi = straj.trajs(index_trajs  ).nodes(end).r(1);
            xf = straj.trajs(index_trajs+1).nodes(1  ).r(1);
            
            yi = straj.trajs(index_trajs  ).nodes(end).r(2);
            yf = straj.trajs(index_trajs+1).nodes(1  ).r(2);            
            
            
            tline = 0:dt:tf;
            hline = ((hf-hi)/tf)*tline + hi;
            xline = ((xf-xi)/tf)*tline + xi;
            yline = ((yf-yi)/tf)*tline + yi;
            
            straj.dt_connections{index_trajs} = array2table([tline' xline' yline' hline'],'VariableNames',{'t','x','y','h'});
            % Graphics condition
            if waitbar_boolean
                waitbar((index_trajs/straj.len),f,[num2str((index_trajs/straj.len)*100),' %']) 
            end          
        end
    end
    %% Corected dt_max 
    straj.dt = straj.trajs(index_trajs).dt;
    straj.dt_max = index2time(straj,"end","end");
    
    %%
    tline = timeline(straj);
    mt_time = zeros(length(tline),4);

    index = 0;
    for t = timeline(straj)
        index = index + 1;
        result = step(straj,t,'all',true);
        mt_time(index,1) = result.x;
        mt_time(index,2) = result.y;
        mt_time(index,3) = result.h;
        mt_time(index,4) = t;
    end
    straj.mt_time = mt_time;
    %%
    %% Remove Pre - signals
    straj.signals = [];
    if waitbar_boolean
        delete(f)
        msgbox_iur('It has been generated velocity','Velocity Generation Finished','Position',[0.4 0.4 0.15 0.1]);
    end          
    
end 

