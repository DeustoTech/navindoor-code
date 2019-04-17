classdef BeaconSgn < signal
    %BEACONSGN Summary of t his class goes here
    %   Detailed explanation goes here
    
    properties
        type    {mustBeMember(type,{'RSS','ToF','AoA'})} = 'RSS'
        beacons 
    end
    
    methods
        function obj = BeaconSgn(itraj,type,map,beacons,varargin)
            %BEACONSGN Construct an instance of this class
            %   Detailed explanation goes here
            r = default_values();
                        
            p = inputParser;
            addRequired(p,'itraj')
            addRequired(p,'type')
            addRequired(p,'beacons',@valid_beacons)
            addRequired(p,'map')

            addOptional(p,'frecuency',itraj.GroundTruths.Ref.frecuency,@valid_frecuency)

            switch type 
                case 'RSS'
                    Event2msFcn = r.BeaconSgn.Event2msFcn.RSS;
                    Event2msParams = r.BeaconSgn.Event2msParams.RSS;
                case 'ToF'
                    Event2msFcn = r.BeaconSgn.Event2msFcn.ToF;
                    Event2msParams = r.BeaconSgn.Event2msParams.ToF;
                case 'AoA'
                    Event2msFcn = r.BeaconSgn.Event2msFcn.AoA;
                    Event2msParams = r.BeaconSgn.Event2msParams.AoA;
            end
            addOptional(p,'Event2msFcn',Event2msFcn)
            addOptional(p,'Event2msParams',Event2msParams)
            
            parse(p,itraj,type,beacon,map,varargin{:})
            
            Event2msFcn     = p.Results.Event2msFcn;
            Event2msParams  = p.Results.Event2msParams;
            frecuency       = p.Results.frecuency;
            %%
            
            tend = itraj.GroundTruths.Ref.timeline(end);
            timeline = 0:(1/frecuency):tend;
            %%
            GT = itraj.GroundTruths.Ref;
            %
            ims(length(timeline))    = ms;
            values = zeros(length(beacons),1);
            index = 0;
            
            results = step(GT,timeline,'all',true);
            for t = timeline
                index = index + 1;
                idx_beacon = 0;
                for ibeacon = beacons
                    idx_beacon = idx_beacon + 1;
                    values(idx_beacon) = Event2msFcn(results(index),map,ibeacon,Event2msParams);
                end
                ims(index).values = values;
                ims(index).r = [results(index).x results(index).y results(index).z];
                ims(index).vx = results(index).vx ;
                ims(index).vy = results(index).vy ;
                ims(index).vz = results(index).vz ;
                ims(index).indexs_beacons = 1:length(beacons);
            end
            %%
            obj.timeline        = timeline;
            obj.type            = type;
            obj.mss             = ims;
            obj.beacons         = beacons;
            obj.frecuency       = frecuency;
            obj.Event2msFcn     = Event2msFcn;
            obj.Event2msParams  = Event2msParams;
            %%
            function valid_frecuency(frecuency)
                mustBePositive(frecuency)
            end
            function valid_beacons(beacons)
               mustBeNonempty(beacons) 
            end
        end
        %%
        function result = eq(obj1,obj2)
           if strcmp(obj1.label,obj2.label) && length(obj1.mss) == length(obj2.mss) && obj1.frecuency == obj2.frecuency
              result = true;
           else 
              result = false;
           end   
        end

        function result = ismember(obj,objs)
            result = false;
            for iobj = objs
                if iobj{:} == obj
                   result = true;
                   return
                end
            end
        end
    end
end

