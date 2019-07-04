# Navindoor 
Navindoor is a simulation tool for the design, testing and evaluation of localization algorithms.

It is a platform developed in Matlab that provides the necessary tools to define all the elements that come into play in the different phases of the simulation of a localization system: definition of the scenario, definition of the trajectory and dynamics of the moving object, synthetic generation of signals of different types and characteristics, processing of these signals through different algorithms and evaluation and comparison of the results of the estimates.

Navindoor has been designed in an extensible way, so that it is easy to implement and incorporate new signal and dynamic models and localization algorithms.


# Installation 
To download and install Navindoor, write in the MATLAB console:
```
unzip('https://github.com/DeustoTech/navindoor-code/archive/master.zip')
movefile('navindoor-code-master', 'navindoor','f')
addpath(fullfile(cd,'navindoor')), savepath
cd navindoor
```
Then, for launching Navindoor, write;
```
StartNavindoor
```

# Installation
Requires Matlab R2017b or newer.