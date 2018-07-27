function itraj = velocity(itraj,varargin)
%% VELOCITY
% Crea una nueva trayectoria a partir de la antigua con propiedades v y t.
%
% SYNTAX
% ------
% velocity(trajectory,'section','2','mu','5','sigma','1','k','1','lambda','1')
%
% INPUTS:
% ------
%   - trajectory (mandatory) ___: Object of the trajectory class
%   - 'mu','value'(optional) ___: Mean velocity of the trayectory 
%
% OUTPUTS:
% -------
%   - trajectory _______________: Same trayectory with v and t properties
%    
%
% EXAMPLE
% -------
% % creamos una trayectoria  
%
%   x = 1:0.1:10;
%   y = (x).^2;
%   itraj = mat2traj([x' y'])
%
% % Añadimos velocidad con los valores por defecto
%
%   itraj = velocity(itraj)
%
%   animation(itraj) 
% 
    %% Parameters Asignment
    p = inputParser;p.KeepUnmatched = true; % active, if ther are optionals parameters 

    % mandatories
    addRequired(p,'itraj',@itraj_valid);
    % optionals 
    addOptional(p,'sections',2,@sections_valid);
    addOptional(p,'mu',5,@mu_valid);
    addOptional(p,'sigma',1,@sigma_valid);
    addOptional(p,'k',1,@k_valid);
    addOptional(p,'lambda',1,@lambda_valid);
    addOptional(p,'dt',0.1);

    parse(p,itraj,varargin{:})

    % asignations optionals
    sections = p.Results.sections;
    mu       = p.Results.mu;
    sigma    = p.Results.sigma;
    k        = p.Results.k;
    lambda   = p.Results.lambda;
    dt       = p.Results.dt;
    %% Init
    % =============================================================
    
    T = itraj.distance/mu; % Aprociamcion de la duracion del recorrido
    vrefs = abs(normrnd(mu,sigma,[1 sections])); % valores de velocidad de referencias que tendra la velocidad 
    
    t = 0;
    % La velocidad inicial es siempre la velocidad media 
    y0 = [0;0.1*mu ;0]; 
    vrefs = abs(normrnd(mu,sigma,[1 sections])); % valores de velocidad de referencias que tendra la velocidad 

    % Evolucionamos con RK4 
    [t,yx] = ode45(@f,[t,2*T],y0);

     t = 0;
    % La velocidad inicial es siempre la velocidad media 
    y0 = [0;0.1*mu ;0]; 
    vrefs = abs(normrnd(mu,sigma,[1 sections])); % valores de velocidad de referencias que tendra la velocidad 

    % Evolucionamos con RK4 
    [t,yy] = ode45(@f,[t,2*T],y0);   
    
    
    % asignamos la velocidad a los puntos de la trayectoria que tenemos 
    for index=1:itraj.len
         itraj.vx(index) = interp1(yx(:,1),yx(:,2),itraj.mt(index,1));
         itraj.vy(index) = interp1(yx(:,1),yx(:,2),itraj.mt(index,2));
    end 
    
    itraj.v = sqrt(itraj.vx.^2 + itraj.vy.^2);
    
    % Generamos la lista de valores en t 
    index=1;
    itraj.t(1) = 0;
    for v=itraj.v
        index = index + 1; 
        if itraj.v(end) ~= v
            dt_int = (itraj.x(index) - itraj.x(index-1))/v; 
            itraj.t(index) = itraj.t(index-1) + dt_int;
        end
    end
    
    %% Agregar Peso a los giros 
    
    width_angles = smooth(gradient(tan(itraj.angles),itraj.t),0.1);
    % normalize 
    min_wd_angle = min(width_angles);
    width_angles = width_angles - min_wd_angle;
    
    max_wd_angle = max(width_angles);
    width_angles = width_angles/max_wd_angle;
    
    width_angles = 1.0 - width_angles*0.3;
    
    itraj.v = itraj.v.*width_angles';
    %%
    % equitime 
    tf = itraj.t(end);
    ti = 0;
    % Interpolate of v x 
    new_t = ti:dt:tf;    %% Ahora lo equiespaciamos en el tiempo
    new_x     = arrayfun(@(t) interp1(itraj.t,itraj.x,t,'spline'),new_t);
    new_nodes = arrayfun(@(x) x2vertex(itraj,x),new_x);
    new_v     = arrayfun(@(t) interp1(itraj.t,itraj.v,t,'spline'),new_t);
    
    % Save Properties
    ilevel  =  itraj.level;
    ilabel  =  itraj.label;
    ihight  =  itraj.hight;
    % we create the final output class 
    itraj = traj(new_nodes,'hold_nodes',true);
    
    itraj.v = new_v;
    itraj.t = new_t;
    itraj.dt = dt;
    itraj.level = ilevel;
    itraj.label = ilabel;
    itraj.hight = ihight;
    
    
    % calculamos las proyecciones de la velocidad 
    
    %itraj.vx = itraj.v.*cos_trigo(itraj.angles);
    %itraj.vy = itraj.v.*sin_trigo(itraj.angles);
    
    itraj.ax = gradient(itraj.t,itraj.vx);
    itraj.ay = gradient(itraj.t,itraj.vy);
    
    itraj.a = sqrt(itraj.ax.^2 + itraj.ay.^2);
    
% 
%     smoothdangle = smooth(abs(itraj.dangles),0.05);
%     mindangle = min(smoothdangle);
%     smoothdangle = smooth(smoothdangle,0.05);
%     smoothdangle = smoothdangle - mindangle;
%     maxdangle = max(smoothdangle);
%     smoothdangle = 1 -0.6*smoothdangle/maxdangle;
%     itraj.v = itraj.v.*smoothdangle';
%     itraj.v = smooth(itraj.v)';
         
    function result = f(t,y)
        % y = [x v a]

        if t < T
           vbase = vrefs(floor(sections*t/T) + 1); 
        else
           vbase = vrefs(sections); 
        end

        xs = y(1);
        vs = y(2);
        as = y(3);

        dxs = vs;
        dvs = as;
        das = -k*vs - lambda*as + vbase;

        result = [dxs;dvs;das];
    end 
end


function result = cos_trigo(theta)
    result = 1./sqrt(1+tan(theta).^2);
end

function result = sin_trigo(theta)
    result = tan(theta)./sqrt(1+tan(theta).^2);
end


%% Validatons 
% ========================================================================
% ========================================================================
% ========================================================================
% ========================================================================
function boolean = itraj_valid(itraj)
    boolean = false;
    if ~isa(itraj,'traj')
        error('The first argument must be type traj.')
    else
        boolean = true;
    end
end
function boolean = sections_valid(sections)
    boolean = false;
    if floor(sections) ~= sections
        error('The sections parameter must be integer number.')
    elseif ~isnumeric(sections)
        error('The sections parameter must be type numeric')
    else
        boolean = true;
    end    
end
function boolean = mu_valid(mu)
    boolean = false;
    if ~isnumeric(mu)
        error('The mu parameter must be type numeric')
    else
        boolean = true;
    end    
end
function boolean = sigma_valid(sigma)
    boolean = false;
    if ~isnumeric(sigma)
        error('The mu parameter must be type numeric')
    else
        boolean = true;
    end    
end
function boolean = k_valid(k)
    boolean = false;
    if ~isnumeric(k)
        error('The k parameter must be type numeric')
    else
        boolean = true;
    end    
end
function boolean = lambda_valid(lambda)
    boolean = false;
    if ~isnumeric(lambda)
        error('The mu parameter must be type numeric')
    else
        boolean = true;
    end    
end
