%clear
load('data/builds/EI_UD_conn_AP_fakes_more_APS.mat')
%% Camino en z = 0
r1 = [0 0 0];
r2 = [10 1 0];
r3 = [20 10 0];
r4 = [30 20 0];
r5 = [10 -10 0];
r6 = [-10 -10 0];
%%
b1 = beacon([15 15 0]);
b2 = beacon([35 35 0]);
beacons = [b1 b2];
%%
isegment1 = segment(mat2points([r1 ;r2 ;r3 ;r4;r5;r6]));
isegment1.type = 'byFloor';
%% Camino de z = 0 a z = 10
r5 = [30 20 0];
r6 = [20 20 10];
isegment2 = segment(mat2points([r5 r6]));
isegment2.type = 'byStairs';
%% Camino en z = 10
r7 = [20 20 10];
r8 = [10 1 10];
r9 = [20 10 10];
r10 = [30 20 10];
isegment3 = segment(mat2points([r7 ;r8 ;r9 ;r10]));
isegment3.type = 'byFloor';


%segments = [isegment1 isegment2 isegment3];
segments = isegment1 ;

itraj = traj(segments);
%%
iRSS = BeaconSgn(itraj,'RSS',beacons);
iToF = BeaconSgn(itraj,'ToF',beacons);
iIMU = FreeSgn(itraj,'InertialFoot');

signals = {iRSS,iToF,iIMU};
%%

EKF_estimator = estimator;
EKF_estimator.signals = signals;
EKF_estimator.bucle_function = @EKF_bucle;
EKF_estimator.initial_function = @EKF_init;
EKF_estimator.building = building;
compute(EKF_estimator)


