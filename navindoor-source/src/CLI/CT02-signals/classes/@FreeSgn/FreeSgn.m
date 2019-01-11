classdef FreeSgn < signal
    %BEACONSGN Summary of t his class goes here
    %   Detailed explanation goes here
    
    properties
        type    {mustBeMember(type,{'Barometer','InertialFoot','InertialCoM','Magnetometer'})} = 'Barometer'
    end
    
    methods
        function obj = FreeSgn(itraj,type,varargin)
            %BEACONSGN Construct an instance of this class
            %   Detailed explanation goes here
            r = default_values();
            
            p = inputParser;
            addRequired(p,'itraj')
            addRequired(p,'type')
            switch type 
                case 'Barometer'
                    Event2msFcn     = r.FreeSgn.Event2msFcn.Barometer;
                    Event2msParams  = r.FreeSgn.Event2msParams.Barometer;
                    frecuency       = r.FreeSgn.frecuency.Barometer;
                    dimension       = r.FreeSgn.dimension.Barometer;
                    iGroundTruth    = r.FreeSgn.GroundTruth.Barometer;
                case 'InertialFoot'
                    Event2msFcn     = r.FreeSgn.Event2msFcn.InertialFoot;
                    Event2msParams  = r.FreeSgn.Event2msParams.InertialFoot;
                    frecuency       = r.FreeSgn.frecuency.InertialFoot;
                    dimension       = r.FreeSgn.dimension.InertialFoot;
                    iGroundTruth    = r.FreeSgn.GroundTruth.InertialFoot;
                case 'InertialCoM'
                    Event2msFcn     = r.FreeSgn.Event2msFcn.InertialCoM;
                    Event2msParams  = r.FreeSgn.Event2msParams.InertialCoM;
                    frecuency       = r.FreeSgn.frecuency.InertialCoM;
                    dimension       = r.FreeSgn.dimension.InertialCoM;
                    iGroundTruth    = r.FreeSgn.GroundTruth.InertialCoM;
                case 'Magnetometer'
                    Event2msFcn     = r.FreeSgn.Event2msFcn.Magnetometer;
                    Event2msParams  = r.FreeSgn.Event2msParams.Magnetometer;
                    frecuency       = r.FreeSgn.frecuency.Magnetometer;
                    dimension       = r.FreeSgn.dimension.Magnetometer;
                    iGroundTruth    = r.FreeSgn.GroundTruth.Magnetometer;
            end
            
            
            addOptional(p,'frecuency',frecuency,@frecuency_valid)
            addOptional(p,'Event2msFcn',Event2msFcn)
            addOptional(p,'Event2msParams',Event2msParams)
            addOptional(p,'dimension',dimension)
            addOptional(p,'GroundTruth',iGroundTruth)
            
            parse(p,itraj,type,varargin{:})
            
            Event2msFcn     = p.Results.Event2msFcn;
            Event2msParams  = p.Results.Event2msParams;
            frecuency       = p.Results.frecuency;
            dimension       = p.Results.dimension;
            iGroundTruth    = p.Results.GroundTruth;
            %%
            
            tend = itraj.GroundTruths.Ref.timeline(end);
            timeline = 0:(1/frecuency):tend;
            %%
            %
            ims    = zeros(1,length(timeline),'ms');
            index = 0;
            
            switch iGroundTruth
                case 'Ref'
                    results = step(itraj.GroundTruths.(iGroundTruth),timeline);
                case 'CoM'
                    results = step(itraj.GroundTruths.(iGroundTruth),timeline,'all',true);
                case 'foot'
                    results = step(itraj.GroundTruths.(iGroundTruth),timeline,'all',true);
            end
            for t = timeline
                index = index + 1;
               
                ims(index).values = Event2msFcn(results(index),Event2msParams);
                ims(index).r = [results(index).x results(index).y results(index).z];
                ims(index).vx = results(index).vx ;
                ims(index).vy = results(index).vy ;
                ims(index).vz = results(index).vz ;

            end
            %%
            obj.timeline        = timeline;
            obj.type            = type;
            obj.mss             = ims;
            obj.frecuency       = frecuency;
            obj.Event2msFcn     = Event2msFcn;
            obj.Event2msParams  = Event2msParams;
            
            %%
            %%
            function frecuency_valid(frecuency)
                mustBePositive(frecuency)                    
            end
        end
        
    end
end

