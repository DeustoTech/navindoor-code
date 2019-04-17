function mt_trajectory = ekf_mathworks(signals,imap,itraj)

   
    %% find RSS_Signal 
    logical_index = arrayfun(@(index) strcmp(signals{index}.type,'RSS'),1:length(signals));
    index_rss = find(logical_index,1);
    sigma_rss = 0.1;
    %% find Barometer Signal
    logical_index = arrayfun(@(index) strcmp(signals{index}.type,'Barometer'),1:length(signals));
    index_baro = find(logical_index,1);    
    sigma_baro = 0.1;
    %% dynamics
    n=5;      %number of state
    q=1;    %std of process         
    Q=q^2*eye(n); % covariance of process
    % Time constant
    dt = signals{1}.timeline(2) - signals{1}.timeline(1) ;
    % Dynamic Model
    f=@(x) [x(1) + dt*x(4) ; ...    %  x
            x(2) + dt*x(5) ; ...    %  y
            x(3);            ...    %  z
            x(4) ;           ...    % vx
            x(5) ];                 % vy
    %
    P = eye(n);                               % initial state covraiance
    %%
    initState = step(itraj,0);
    x = [initState.x initState.y initState.z initState.vx initState.vy];
    
    mt_trajectory = zeros(length(signals{1}.timeline),4);

    %% Main Bucle
    k = 0;
    for t = signals{1}.timeline
      k = k + 1;
      % Obtain Measurements
      Measurements = [];
      Noise        = [];
      % rss
      if ~isempty(index_rss)
          % filtramos los que estan en la misma planta
          result_rss =  step(signals{index_rss},t);          
          u = vec2mat([signals{index_rss}.beacons([result_rss.indexs_beacons]).r],3); 
          %% selecionamos beacon de la misma altura
          index_bolean = u(:,end) - x(3) < 0.5;
          u = u(index_bolean,:);
          result_rss.indexs_beacons = result_rss.indexs_beacons(index_bolean);
          result_rss.values = result_rss.values(index_bolean);
          %%
          Measurements = [Measurements ;result_rss.values];
          Noise = [Noise; repmat(sigma_rss,length(result_rss.values),1)];
      end
      % Barometer
      if ~isempty(index_baro)
          results_baro =  step(signals{index_baro},t);
          Measurements = [Measurements ;results_baro.values];
          Noise = [Noise; repmat(sigma_baro,length(results_baro.values),1)];
      end
      % Elegimos la funcion de medidas, segun las señales que nos lleguen
      if  ~isempty(index_rss) && ~isempty(index_baro)
          fcn_ms = @(x) [u2rss(x,u);hight2pressure(x(3))];
      elseif ~isempty(index_rss) && isempty(index_baro)
          fcn_ms = @(x) u2rss(x,u);
      else
          fcn_ms = @(x) hight2pressure(x(3));
      end
      % Creamos la matrix de covarianza de medidas
      R=diag(Noise);        

      [x, P] = ekf(f,x,P,fcn_ms,Measurements,Q,R); 
      if abs(x(3)) < 0.5
          x(3) = 0;
      end
      mt_trajectory(k,:) = [x(1) x(2) x(3) t]' ;
    end
    
end
%%
% END
%%

function [x,P]=ekf(fstate,x,P,hmeas,z,Q,R)
% EKF   Extended Kalman Filter for nonlinear dynamic systems
% [x, P] = ekf(f,x,P,h,z,Q,R) returns state estimate, x and state covariance, P 
% for nonlinear dynamic system:
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
  [x, P] = ekf(f,x,P,h,z,Q,R);            % ekf 
  xV(:,k) = x;                            % save estimate
  s = f(s) + q*randn(3,1);                % update process 
end
for k=1:3                                 % plot results
  subplot(3,1,k)
  plot(1:N, sV(k,:), '-', 1:N, xV(k,:), '--')
end
%}
% By Yi Cao at Cranfield University, 02/01/2008
%

[x1,A]=jaccsd(fstate,x);    %nonlinear update and linearization at current state
P=A*P*A'+Q;                 %partial update



[z1,H]=jaccsd(hmeas,x1);    %nonlinear measurement and linearization
P12=P*H';                   %cross covariance
% K=P12*inv(H*P12+R);       %Kalman filter gain
% x=x1+K*(z-z1);            %state estimate
% P=P-K*P12';               %state covariance matrix
R=chol(H*P12+R);            %Cholesky factorization
U=P12/R;                    %K=U/R'; Faster because of back substitution
x=x1+U*(R'\(z-z1));         %Back substitution to get state update
P=P-U*U';                   %Covariance update, U*U'=P12/R/R'*P12'=K*P12.

end
%%
function [z,A]=jaccsd(fun,x)
    % JACCSD Jacobian through complex step differentiation
    % [z J] = jaccsd(f,x)
    % z = f(x)
    % J = f'(x)
    %
    z=fun(x);
    n=numel(x);
    m=numel(z);
    A=zeros(m,n);
    h=n*eps;
    for k=1:n
        x1=x;
        x1(k)=x1(k)+h*i;
        A(:,k)=imag(fun(x1))/h;
    end
end

function result = u2rss(x,u)
    result = 10*log10(sqrt((x(1) - u(:,1)).^2 + (x(2) - u(:,2) ).^2 + (x(3) - u(:,3) ).^2));
end
