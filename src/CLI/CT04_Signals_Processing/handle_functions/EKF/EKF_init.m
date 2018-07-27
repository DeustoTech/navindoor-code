function result = EKF_init(estimator,varargin)
%EKF_INIT Summary of this function goes here
%   Detailed explanation goes here
        %% Initial Parameters
        p = inputParser;
        
        addRequired(p,'estimator')
        addOptional(p,'ProcessNoise',[0.50 0.50 0.25 0.25])
        addOptional(p,'HightNoise',0.50)
        addOptional(p,'BaroNoise',0.025)

        parse(p,estimator,varargin{:})
        
        BaroNoise    = p.Results.BaroNoise;
        ProcessNoise = p.Results.ProcessNoise;
        HightNoise   = p.Results.HightNoise;
        %
        
        x0 = estimator.initial_state(1);
        y0 = estimator.initial_state(2);
        h0 = estimator.initial_state(3);
    
        dt = estimator.dt;    
        
        % hieght
        % =====================================================================
        EKF_hight = EKF(@(h) [h(1)+dt*h(2) ; h(2)]      , ... % funcion de trancision
                        @(h) hight2pressure(h(1))       , ... % funcion de medidas
                        [h0;0]);                              % condicion inicial
            
        EKF_hight.ProcessNoise = HightNoise;
        EKF_hight.MeasurementNoise = BaroNoise;  
        
        % x y
        % =====================================================================

        u0 = [x0 y0 0 0];
        EKF_xy = EKF(@StateTransition,  ...
                     @Measurement,      ...
                     u0); 
        EKF_xy.ProcessNoise = diag(ProcessNoise);
        % end function
         result.EKF_xy    = EKF_xy;
         result.EKF_hight = EKF_hight;
         
    %% Auxiliar functions  
     
    function x_new = StateTransition(x,dt)
        %STATETRANSITION 
        % 

        F = [ 1 0 dt 0  ; ...
              0 1 0  dt ; ...
              0 0 1  0  ; ... 
              0 0 0  1  ];

        x_new = F*x;
    end

                 
    function z = Measurement(x,u,estimator) %h(s)
        %MEASUREMENT 
        %  u = matrix [mx2] of beacons positions 
        %  x = matrix [nx1], [x,y,vx,vy]  
        %  
            [nbeacons,~] = size(u);
            i = 1;
            
            z = zeros((length(estimator.signals)-1)*nbeacons,1);
            for isignal = estimator.signals
                
                switch isignal{:}.type
                    case 'RSS'
                        z( i:(i+nbeacons-1) ) = u2rss(x,u);
                    case 'ToF'
                        z( i:(i+nbeacons-1) ) = u2tof(x,u);
                    case 'AoA'
                        z( i:(i+nbeacons-1) ) = u2aoa(x,u);
                end
                i = i + nbeacons;
            end
            
            function result = u2rss(x,u)
                result = 10*log10(sqrt((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2));
            end

            function result = u2tof(x,u)
                c = 1;
                result = sqrt((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2)/c;
            end 
            function result = u2aoa(x,u)
                
                itheta = atan_2pi([x(3),x(4)]);
                R =[ cos(itheta) -sin(itheta) ; sin(itheta) cos(itheta)];
                
                result = zeros(1,length(u));
                index = 0;
                for row = u'
                    index = index + 1;
                    result(index) = atan_2pi((row'-x(1:2))*R);
                end
            end
        end

        %%
  
    

end

