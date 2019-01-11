classdef segment
    % Segment es un subconjunto de puntos donde se puede aplicar un mismo modelo de velocidad 
    properties
        % Puntos que definen el segmento
        points              point    = point
        % La propiedad type se utiliza para saber que tipo de modelo deberemos aplicar a este segmento para modelizar 
        % la curva de velocidad 
        type                char   {mustBeMember(type,{'byStairs','byElevator','byFloor'})} = 'byFloor' 
        %
        cumsum  = double.empty
    end
    
    methods
        function obj = segment(points,varargin)
            %TRAJ Construct an instance of this class
            %   Detailed explanation goes here
            if nargin == 0
                return
            end
            
            p = inputParser;
            addRequired(p,'points')
            addOptional(p,'type','byFloor')
            
            parse(p,points)
            
            obj.points = points;
            %%
            obj.cumsum = zeros(1,length(points));
            for index = 2:length(points)
                obj.cumsum(index) = norm(points(index).r - points(index-1).r);
            end
            obj.cumsum = cumsum(obj.cumsum);
        end
        
        
    end
end

