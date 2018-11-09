classdef signal
    %SIGNAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mss
        label           = 'signal'
        frecuency
        timeline
    end
    
    properties (Hidden)
        Event2msFcn
        Event2msParams 
    end
    
end

