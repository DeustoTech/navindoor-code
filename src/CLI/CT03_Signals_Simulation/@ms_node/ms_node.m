classdef ms_node<node
    %DOOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        t           = 0
        values    = []
        indexs_beacons
    end
    
    methods
        %% constructor & settings
        function obj = ms_node(inode,maxbeacons)
            if nargin > 1
                obj.r=inode.r;
                obj.level=inode.level;
                obj.values = zeros(1,maxbeacons);
            end
        end
        
    end
    methods (Static)
          function z = zeros(varargin)
          %% Zeros constructor 
             if (nargin == 0)
                z = ms_node;
             elseif any([varargin{:}] <= 0)
             % For zeros with any dimension <= 0   
                z = ms_node.empty(varargin{:});
             else
             % Use property default values
                z = repmat(ms_node,varargin{:});
             end
          end
       end
    
end

