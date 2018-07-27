function result=x2vertex(itraj,x)
    %% X2VERTEX 
    %
    %
    % EXAMPLE
    % =======
    % clear
    % y = 
    xnode = interp1(itraj.x,itraj.mt(:,1),x,'spline');
    ynode = interp1(itraj.x,itraj.mt(:,2),x,'spline');
    result = vertex([xnode ynode]); 
    
    [~,index] = min(abs(x-itraj.x));
    result.level = itraj.nodes(index).level;
end
