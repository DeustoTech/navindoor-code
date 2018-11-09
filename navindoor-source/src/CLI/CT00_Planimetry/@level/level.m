classdef level
% LEVEL Set of point and walls that represents a level within a building  
    % *** Example
    %
    properties
        nodes           = zeros(0,0,'node')     % nodes is the list of nodes of a level  
        walls           = zeros(0,0,'wall')     % walls is the list of walls of a level
        doors           = zeros(0,0,'door')     % doors is the list of doors of a level
        beacons         = zeros(0,0,'beacon')   % beacons is the list of beacons of a level
        elevators       = zeros(0,0,'elevator') % list of elevators of this level 
        stairs          = zeros(0,0,'stairs')   % list of stair of this level
        n               = 0                     % n is the ordinal number that identifies a level or floor, inside a building 
        dimensions      = [50 50]               % [height width] of level         
        north           = 0                     % Angle where north is 
        height = 0                              % Height of level
    end
    
    methods
        %% constructor


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

