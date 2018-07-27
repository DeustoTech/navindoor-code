function extract_data(namefile,isupertraj,beacons,dt)

   isupertraj = equitime(isupertraj,dt);
   nodes = [isupertraj.trajs.nodes];
   nlvl = [nodes.level]';

   mt = [];
   len = length(isupertraj.trajs);
   for index = 1:len
    mt = [mt isupertraj.trajs(index).mt'];
   end
   mt = mt';

   lennodes = length(nodes);

   db = (0:dt:(dt*(lennodes-1)))';
   db = [ db , mt , nlvl];


    for ibeacon=beacons 
        db = [db (arrayfun(@(x) distn(x,ibeacon),nodes))'];
    end    

    for ibeacon=beacons 
        db = [db (arrayfun(@(x) anglearr(x,ibeacon),nodes))'];
    end    
    fileID = fopen(namefile,'w');
    fprintf(fileID,num2str(length(beacons)));
    fprintf(fileID,'\n');

    dlmwrite(namefile,vec2mat([beacons.r],2),'-append');
    dlmwrite(namefile,db,'-append');
    fclose(fileID);


end    
