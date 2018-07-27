classdef iurlistbox 
    %IURLISBOX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        object 
        RightClickCallback
        LeftClickCallback
        
    end
    
    methods
        function obj = iurlistbox
            obj.object = uicontrol('style','listbox');
            obj.callback = @callback;
            
            function callback(varargin)
                event = varargin{2};
                
            end
        end
    end
end

