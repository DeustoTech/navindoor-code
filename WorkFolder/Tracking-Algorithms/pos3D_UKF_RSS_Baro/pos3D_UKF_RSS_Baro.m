function mt_trajectory = pos3D_UKF_RSS_Baro(signals,ibuilding,itraj)
    
    %% Vector state initial values
    initState = step(itraj,0);
    x = [initState.x initState.y initState.z initState.vx initState.vy initState.vy]'; %Column vector       
    
    %% Vector state initial covariance
    pos_xy_var=0.5^2; %m
    pos_z_var=0.2^2; %m
    vel_xy_var=0.5^2; %m/s
    vel_z_var=0.2^2; %m/s
    P = diag([pos_xy_var pos_xy_var pos_z_var vel_xy_var vel_xy_var vel_z_var]);
    
    %% Dynamic Model: constant velocity + acc noise driven model
    % Fixed delta from the first signal, assuming that both have the same
    % sampling rate and are synchronized
    dt = signals{1}.timeline(2) - signals{1}.timeline(1) ;
    f=@(x) [x(1) + dt*x(4) ; ...    %  x
            x(2) + dt*x(5) ; ...    %  y
            x(3) + dt*x(6) ; ...    %  z
            x(4);            ...    %  vx
            x(5);           ...    % vy
            x(6) ];                % vz
    % Dynamic model process noise: acceleration noise driven
    acc_xy_var=0.5^2; %m/s^2
    acc_z_var=0.5^2; %m/s^2

    Q = [acc_xy_var*dt^4/4 0 0 acc_xy_var*dt^3/2 0 0;...
        0 acc_xy_var*dt^4/4 0 0 acc_xy_var*dt^3/2 0;...
        0 0 acc_z_var*dt^4/4 0 0 acc_z_var*dt^3/2;...
        acc_xy_var*dt^3/2 0 0 acc_xy_var*dt^2 0 0;...
        0 acc_xy_var*dt^3/2 0 0 acc_xy_var*dt^2 0;...
        0 0 acc_z_var*dt^3/2 0 0 acc_z_var*dt^2];
    
    %% Measurement model
    RSS_var=0.1^2; % dB
    barometer_var=1^2; % m
    for isignal = signals
        if strcmp(isignal{1}.type,'RSS')
            dim = length(isignal{1}.beacons);
        end
    end
    %dim = length(signals{1}.beacons);
    R=RSS_var*eye(dim);
    R(end+1,end+1)=barometer_var;
        
    
    %% Initialization of estimation storing variable
    mt_trajectory = zeros(length(signals{1}.timeline),4);

    %% Main Bucle
    k = 0;
    for t = signals{1}.timeline
      k = k + 1;
      % Obtain Measurements
      RSS_measurements =  step(signals{1},t);
      APs_coord = vec2mat([signals{1}.beacons([RSS_measurements.indexs_beacons]).r],3); 
      
      Barometer_measurements =  step(signals{2},t);
      
      Measurement_model = @(x) [u2rss(x,APs_coord);height2pressure(x(3))];
      
      Measurements =[RSS_measurements.values;Barometer_measurements.values];
      
      [x, P] = ukf(f,x,P,Measurement_model,Measurements,Q,R); 
            
      mt_trajectory(k,:) = [x(1) x(2) x(3) t]' ;
    end
    
end
%%
% END
%%

function [x,P] = ukf(fstate,x,P,hmeas,z,Q,R)
% UKF   (Scaled) Unscented Kalman Filter for nonlinear dynamic systems
% [x, P] = ukf(f,x,P,h,z,Q,R) returns state estimate, x and state covariance, P 
% for nonlinear dynamic system (for simplicity, noises are assumed as additive):
%           x_k+1 = f(x_k) + w_k
%           z_k   = h(x_k) + v_k
% where w ~ N(0,Q) meaning w is gaussian noise with covariance Q
%       v ~ N(0,R) meaning v is gaussian noise with covariance R
% Inputs:   f: function handle for f(x)
%           x: "a priori" state estimate
%           P: "a priori" estimated state covariance
%           h: fanction handle for h(x)
%           z: current measurement
%           Q: process noise covariance 
%           R: measurement noise covariance
% Output:   x: "a posteriori" state estimate
%           P: "a posteriori" state covariance
%
% Example:
%{
n=3;      %number of state
q=0.1;    %std of process 
r=0.1;    %std of measurement
Q=q^2*eye(n); % covariance of process
R=r^2;        % covariance of measurement  
f=@(x)[x(2);x(3);0.05*x(1)*(x(2)+x(3))];  % nonlinear state equations
h=@(x)x(1);                               % measurement equation
s=[0;0;1];                                % initial state
x=s+q*randn(3,1); %initial state          % initial state with noise
P = eye(n);                               % initial state covraiance
N=20;                                     % total dynamic steps
xV = zeros(n,N);          %estmate        % allocate memory
sV = zeros(n,N);          %actual
zV = zeros(1,N);
for k=1:N
  z = h(s) + r*randn;                     % measurments
  sV(:,k)= s;                             % save actual state
  zV(k)  = z;                             % save measurment
  [x, P] = ukf(f,x,P,h,z,Q,R);            % ekf 
  xV(:,k) = x;                            % save estimate
  s = f(s) + q*randn(3,1);                % update process 
end
for k=1:3                                 % plot results
  subplot(3,1,k)
  plot(1:N, sV(k,:), '-', 1:N, xV(k,:), '--')
end
%}
% Reference: Julier, SJ. and Uhlmann, J.K., Unscented Filtering and
% Nonlinear Estimation, Proceedings of the IEEE, Vol. 92, No. 3,
% pp.401-422, 2004. 
%
% By Yi Cao at Cranfield University, 04/01/2008

    L = numel(x);                                 %numer of states
    m = numel(z);                                 %numer of measurements
    alpha = 1e-3;                                 %default, tunable (0 <= alpha <= 1)
    % [controls the size of the sigma points distribution and should ideally be a small number 
    % to avoid sampling non-local effects when the non-linearities are strong]
    kappa = 0;                                    %default, tunable (kappa >= 0)
    % [to guarantee positive semidefiniteness of the covariance matrix. It is not so critical, a good value kappa = 0]
    beta = 2;                                     %default, tunable (beta >= 0)
    % [It can be used to incorporate knowledge of the higher order moments of the distribution. For Gaussian prior, optimal beta = 2]
    lambda = alpha^2*(L+kappa)-L;                 %scaling factor
    c = L+lambda;                                 %scaling factor
    Wm = [lambda/c 0.5/c+zeros(1,2*L)];           %weights for means
    Wc = Wm;
    Wc(1) = Wc(1)+(1-alpha^2+beta);               %weights for covariance
    c = sqrt(c);

    %sigma points around x
    X = sigmas(x,P,c);                            

    %unscented transformation of process
    [x1,X1,P1,X2] = ut(fstate,X,Wm,Wc,L,Q);       
    % X1 = sigmas(x1,P1,c);                         %sigma points around x1
    % X2 = X1-x1(:,ones(1,size(X1,2)));             %deviation of X1

    %unscented transformation of measurments
    [z1,Z1,P2,Z2] = ut(hmeas,X1,Wm,Wc,m,R); 

    P12 = X2*diag(Wc)*Z2';                        %transformed cross-covariance
    K = P12/P2;
    x = x1+K*(z-z1);                              %state update
    P = P1-K*P12';                                %covariance update
end

function [y,Y,P,Y1] = ut(f,X,Wm,Wc,n,R)
%Unscented Transformation
%Input:
%        f: nonlinear map
%        X: sigma points
%       Wm: weights for mean
%       Wc: weights for covraiance
%        n: numer of outputs of f
%        R: additive covariance
%Output:
%        y: transformed mean
%        Y: transformed smapling points
%        P: transformed covariance
%       Y1: transformed deviations

    L = size(X,2);
    y = zeros(n,1);
    Y = zeros(n,L);
    for k=1:L                   
        Y(:,k) = f(X(:,k));       
        y = y+Wm(k)*Y(:,k);       
    end
    Y1 = Y-y(:,ones(1,L));
    P = Y1*diag(Wc)*Y1'+R;    
end

function X = sigmas(x,P,c)
%Sigma points around reference point
%Inputs:
%       x: reference point
%       P: covariance
%       c: coefficient
%Output:
%       X: Sigma points

    A = c*chol(P)';
    Y = x(:,ones(1,numel(x)));
    X = [x Y+A Y-A]; 
end

function result = u2rss(x,u)
    result = 10*log10(sqrt((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2 + (x(3) - u(:,3) ).^2));
end
