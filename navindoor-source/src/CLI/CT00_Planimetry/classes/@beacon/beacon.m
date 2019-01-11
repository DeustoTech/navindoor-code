classdef beacon<node
    % La clase Beacon es usada para representar las distintas balizas que existen dentro de un edificio. Es es una subclase de node, por lo que tiene unas coordenadas en el espacio 
    % Es utilizada junto con los objetos traj para generar las senales tipo BeaconSgn. Gracias a que sabemos la posicion en el espacio de la baliza podemos calcular la distancias
    % durante toda la trajectoria 
    properties
        frecuency = 1; % This property represents the refresh rate of the access point
        level = 0      % Numero ordinal que indica la planta en la que esta la balizas. Sin embargo esta informacion se encuentra ya en la propiedad z, por ser una subclase de node. 
    end
    
    methods
        %% constructor & settings
        function obj = beacon(r,varargin)
            %% Null element
            if nargin == 0
               return 
            end
            %% Parameters Assignment
            
            p = inputParser;
            addRequired(p,'r')
            addOptional(p,'frecuency',1)
            addOptional(p,'level',0)

            parse(p,r,varargin{:})
            %%
            obj.r           = p.Results.r;
            obj.frecuency   = p.Results.frecuency;
            obj.level       = p.Results.level;
        end
        
    end
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = beacon;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = beacon.empty(varargin{:});
             else
             % Use property default values
                z = repmat(beacon,varargin{:});
             end
          end
       end
    
end

