classdef help_btn
    %HELP_BTN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        handle
        java
    end
    
    methods
        function obj = help_btn(varargin)
            %HELP_BTN Construct an instance of this class
            %   Detailed explanation goes here
            
            p = inputParser;
            addOptional(p,'Parent',gcf);
            addOptional(p,'Position',[0.2 0.2 0.6 0.6])
            addOptional(p,'msg',[])
            addOptional(p,'CreateStruct',[])
            parse(p,varargin{:});
            
                        
            Parent       = p.Results.Parent;
            Position     = p.Results.Position;
            msg          = p.Results.msg;
            CreateStruct = p.Results.CreateStruct;
            
            import javax.swing.ImageIcon
        
            [obj.handle,obj.java] = uicomponent(javax.swing.JButton,'Parent',Parent);
            obj.handle.Units='normalize';
            obj.handle.Position = Position;
            
            try
                [X,map] = imread('src/iur/imgs/help.png','Background',[0.9400 0.9400 0.9400]);
            catch 
                [X,map] = imread('src/iur/imgs/help.png');
            end
            if ~isempty(map)
                obj.java.setIcon(ImageIcon(im2java(X,map)));
            else
                obj.java.setIcon(ImageIcon(im2java(X)));
            end
    
            obj.java.setBorder([])
            if ~isempty(msg)
                    obj.handle.MouseClickedCallback = {@help_event,msg,'CreateStruct',CreateStruct};
            end
            

        end
        
        
    end
end

