itraj1 = load('/Users/jesusoroya/Documents/GitHub/navindoor-code/WorkFolder/traj1.mat');
itraj1 = itraj1.itraj;
itraj2 = load('/Users/jesusoroya/Documents/GitHub/navindoor-code/WorkFolder/traj2.mat');
itraj2 = itraj2.itraj;

ibuilding = load('/Users/jesusoroya/Documents/GitHub/navindoor-code/WorkFolder/building1.mat');
ibuilding = ibuilding.building;

line2d([itraj1.GroundTruths.Ref itraj2.GroundTruths.Ref],'building',ibuilding)
