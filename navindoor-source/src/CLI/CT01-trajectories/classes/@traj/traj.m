classdef traj
    %TRAJ Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        segments
        GroundTruths 
        label           = 'traj'
    end
    properties (Hidden)
        byFloorFcn
        byFloorParams
        %
        byStairsFcn
        byStairsParams
        %
        byElevatorsFcn
        byElevatorsParams
        %
        foot2RefFcn
        foot2RefParams
        % 
        FootFrecuency
        mt
        points
    end
    
    methods
        function obj = traj(segments,varargin)
            
            % load defaults 
            r = default_values();
            % start input vars definition
            p = inputParser;
            addRequired(p,'segments')
            % 
            addOptional(p,'byFloorFcn'       ,r.traj.byFloorFcn)       % byFloorFcn       $ function que modela el movimiento del centro de masa de una persona en una planta 
            addOptional(p,'byFloorParams'    ,r.traj.byFloorParams)                    % byFloorFcnParms  $ function que modela el movimiento del centro de masa de una persona en una planta 
            %
            addOptional(p,'byStairsFcn'      ,r.traj.byStairsFcn) 
            addOptional(p,'byStairsParams'   ,r.traj.byStairsParams)
            %
            addOptional(p,'byElevatorsFcn'   ,r.traj.byElevatorsFcn)
            addOptional(p,'byElevatorsParams',r.traj.byElevatorsParams)
            
            addOptional(p,'foot2RefFcn'      ,r.traj.foot2RefFcn)
            addOptional(p,'foot2RefParams'   ,r.traj.foot2RefParams)

            addOptional(p,'FootFrecuency'    ,r.traj.FootFrecuency)

            parse(p,segments,varargin{:})

            obj.segments            = p.Results.segments;

            obj.byFloorFcn          = p.Results.byFloorFcn;
            obj.byFloorParams       = p.Results.byFloorParams;
            %
            obj.byStairsFcn         = p.Results.byStairsFcn;
            obj.byStairsParams      = p.Results.byStairsParams;

            obj.byElevatorsFcn      = p.Results.byElevatorsFcn;
            obj.byElevatorsParams   = p.Results.byElevatorsParams;
            %
            obj.foot2RefFcn         = p.Results.foot2RefFcn;
            obj.foot2RefParams      = p.Results.foot2RefParams;

            %
            obj.FootFrecuency       = p.Results.FootFrecuency;

            %% init
            
            Events_foot = [];
            for jsegm = segments
                switch jsegm.type
                    case  'byFloor'
                        Events_foot = [Events_foot, obj.byFloorFcn(jsegm,obj.FootFrecuency,obj.byFloorParams{:})];
                    case  'byStairs'
                        Events_foot = [Events_foot, obj.byStairsFcn(jsegm,obj.FootFrecuency,obj.byStairsParams{:})];
                    case  'byElevator'
                        Events_foot = [Events_foot, obj.byElevatorsFcn(jsegm,obj.FootFrecuency,obj.byElevatorsParams{:})];
                end
            end
            obj.GroundTruths.foot = GroundTruth(Events_foot,obj.FootFrecuency,'foot');
            %% from Event foot to Event CoM
            obj.GroundTruths.Ref  = obj.foot2RefFcn(obj.GroundTruths.foot,obj.foot2RefParams{:});
           
            x = [obj.GroundTruths.Ref.Events.x];
            y = [obj.GroundTruths.Ref.Events.y];
            z = [obj.GroundTruths.Ref.Events.z];
            t = obj.GroundTruths.Ref.timeline;
            
            obj.mt = [x' y' z' t'];
            obj.points = [obj.segments.points];
        end
        

    end
end

