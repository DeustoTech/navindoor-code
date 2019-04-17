function index = xy2indexbuilding(imap,r)
% Devuelve el indice de building al que pertenece la coordenada 
    ibuildings = [imap.buildings];
    iborders   = [ibuildings.border];
    ps = [iborders.polyshape];
    
    index = 0;
    for ips = ps
        index = index + 1;
        if isinterior(ips,r)
           return 
        end
    end
    index = [];
end

