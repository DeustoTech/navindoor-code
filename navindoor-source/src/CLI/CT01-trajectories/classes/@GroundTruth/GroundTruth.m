classdef GroundTruth
    %GROUNDTRUTH Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Events
        frecuency
        type          {mustBeMember(type,{'CoM','foot','Ref'})} = 'CoM'
        timeline
    end
    
    properties (Hidden)
        Stance                      % Stance - Only It is used when type of GroundTruth is 'foot'. This is boolean array that represents the 
    end
    
    methods
        function obj = GroundTruth(Events,frecuency,type)
            if nargin == 0
               return 
            end
            obj.Events = Events;
            obj.frecuency = frecuency;
            obj.type = type;
            
            obj.timeline = 0:(1/frecuency):(1/frecuency)*(length(Events)-1);
        end
    end
end

