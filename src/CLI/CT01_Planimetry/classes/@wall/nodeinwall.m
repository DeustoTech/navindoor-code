function result = nodeinwall(walls,node)
   nodewalls = [];
   otherwalls = [];
   for iwall = walls
       if iwall.nodes(1) == node || iwall.nodes(2) == node 
           nodewalls = [nodewalls iwall];
       else
           otherwalls = [otherwalls iwall];
       end
   end
   result{1} = nodewalls;
   result{2} = otherwalls;
end