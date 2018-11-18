# Navindoor MATLAB Software 

Navindoor is a simulation and signal processing software for the purpose of
indoor location

# Features


# Getting Started
To begin we must add the following paths
```matlab
addpath(genpath('WorkFolder'))
addpath(genpath('navindoor-source'))
```
or we just run StartNavindoor;
```matlab
StartNavindoor
```
his allows us to access all functions within the `WorkFolder` and` navindoor-source` 
folders. Below we will briefly describe these two folders: 
- **WorkFolder**: It contains the localization algorithms, the noise models to generate signals, 
it also contains the models that generate the trajectories. This folder will contain all our 
development
- **navindoor-source**: It contains all functionality of this framework;

To open the graphical interface we must write the following command:
```matlab
navindoor
```
## Create planimetry



