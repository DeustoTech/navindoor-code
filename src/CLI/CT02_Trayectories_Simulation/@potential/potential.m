classdef potential
    %NPOTENTIAL is numerical potential of level
    %   
    
    properties
            X           =[]          % ndgrid X
            Y           =[]          % ndrid Y
            Z           =[]          % function ndgrid Z
            dx          =[]          % ndgrid dZ/dx
            dy          =[]          % ndgrid dZ/dy
            precision  = 0.5         % presicion
    end
    
    methods
        function obj = potential(X,Y,Z)
        %  Generation of a grid that represents a field of potential energy
        %  associated with a level.
            if nargin > 0 
                obj.X = X;
                obj.Y = Y;
                obj.Z = Z;
                [obj.dy ,obj.dx] = gradient(-Z);
                obj.precision = (X(2,1)-X(1,1));
            end   
        end
        function pot = plus(pot1,pot2)
            totalZ  = pot1.Z + pot2.Z;
            pot = potential(pot1.X,pot1.Y,totalZ);
        end
        function plot(obj)     
            surf(obj.X,obj.Y,obj.Z)
        end
       
        
    end
end

