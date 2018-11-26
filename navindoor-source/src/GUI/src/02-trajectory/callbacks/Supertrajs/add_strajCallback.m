function add_strajCallback(object,event,h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

     prompt={'Enter the name of new trajectory layer'};
     name='Input for Peaks function';
     defaultanswer={['traj_',num2str(1+length(h.trajectory_layer),'%.3d')]};    
     numlines = 1;
     
     answer=inputdlg(prompt,name,numlines,defaultanswer);

     h.trajectory_layer(end+1) = trajectory_layer;
   
     h.trajectory_layer(end).label = answer{:};
    update_trajectory_layer(h)
    
end

