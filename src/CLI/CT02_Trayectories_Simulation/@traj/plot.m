function plot(itrajs,varargin)
    
    for itraj = itrajs
        line(itraj.nodes,varargin{:});
    end
end   
