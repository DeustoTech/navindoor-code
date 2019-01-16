classdef Event < point
    %EVENT 
    
    properties
        vx = 0
        vy = 0
        vz = 0
    end

    properties (Hidden)
        
        ax  = 0
        ay  = 0
        az  = 0
         
        gyrox = 0
        gyroy = 0
        gyroz = 0
        %
        attx = 0
        atty = 0
        attz = 0
        % 
        stance = 0   
    end
    methods
        function obj = Event(r)
            if nargin == 0
               return 
            end
            
            [nrow ,~] = size(r);
            obj = zeros(1,nrow,'Event');
            for i = 1:nrow
                obj(i).r = r(i,:);
            end
        end

    end
    methods (Static)
      function z = zeros(varargin)
         if (nargin == 0)
         % For zeros('Event')
            z = Event;
         elseif any([varargin{:}] <= 0)
         % For zeros with any dimension <= 0   
            z = Event.empty(varargin{:});
         else
         % For zeros(m,n,...,'Color')
         % Use property default values
            z = repmat(Event,varargin{:});
         end
      end
    end
end

