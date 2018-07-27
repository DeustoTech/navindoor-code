classdef level
%% Set of point and walls that represents a level within a building  
    properties
        nodes           = zeros(0,0,'node')     % nodes is the list of nodes of a level  
        walls           = zeros(0,0,'wall')     % walls is the list of walls of a level
        doors           = zeros(0,0,'door')     % doors is the list of doors of a level
        beacons         = zeros(0,0,'beacon')   % beacons is the list of beacons of a level
        elevators       = zeros(0,0,'elevator')     % elevators 
        stairs          = zeros(0,0,'stairs')  
        n               = 0                     % n is the ordinal number that identifies a level or floor, inside a building 
        dimensions      = [50 50]               % [height width] of level         
        widthdoors      = 2
        widthwalls      = 1
        levels_distance = 0
        north           = 0
        truelevel       = false
        high = 0
    end
    
    methods
        %% constructor
        function obj = level(innodes,inwalls,indoors,ibeacons,dimensions)
            if nargin > 0 
                if ~isempty(innodes)
                    obj.nodes = innodes;
                end

                if ~isempty(inwalls)
                    obj.walls = inwalls;
                end

                if ~isempty(indoors)
                    obj.doors = indoors;
                end

                if ~isempty(ibeacons)
                    obj.beacons = ibeacons;
                end        
                obj.dimensions = dimensions;
            end
        end

        %% Set widthwalls
        function level=set.widthwalls(level,width)
           level.widthwalls = width;
           len = length(level.walls);
           for index=1:len
               level.walls(index).width = width;
           end
        end
        
        %% Set widthdoors
        function level=set.widthdoors(level,width)
           level.widthdoors=width;
           len = length(level.walls);
           for windex=1:len
               lendoors = length(level.walls(windex).doors);
               for dindex=1:lendoors
                    level.walls(windex).doors(dindex).width = width;
               end
           end
        end
        
        %%  Set n 
        function obj=set.n(obj,nlevel)
            if ~obj.truelevel 
               obj.truelevel = true;
               len = length(obj.walls);

               for nindex=1:len
                   obj.walls(nindex).level = nlevel;
                   obj.walls(nindex).nodes(1).level = nlevel;
                   obj.walls(nindex).nodes(2).level = nlevel;

                   lendoors = length(obj.walls(nindex).doors);
                   for dindex=1:lendoors
                        obj.walls(nindex).doors(dindex).level = nlevel;
                   end

               end
              len = length(obj.nodes);
              for nindex=1:len
                   obj.nodes(nindex).level = nlevel;
              end            
               len = length(obj.beacons);
              for nindex=1:len
                   obj.beacons(nindex).level = nlevel;
              end           

              len = length(obj.doors);
              for nindex=1:len
                   obj.doors(nindex).level = nlevel;
              end   
              obj.n = nlevel;

        end
        end


    end
        methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = level;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = level.empty(varargin{:});
             else
             % Use property default values
                z = repmat(level,varargin{:});
             end
          end
       end
end

