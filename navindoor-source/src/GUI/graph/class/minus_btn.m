classdef minus_btn
    %HELP_BTN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        handle
        java
    end
    
    methods
        function obj = minus_btn(varargin)
            %HELP_BTN Construct an instance of this class
            %   Detailed explanation goes here
            
            p = inputParser;
            addOptional(p,'Parent',gcf);
            addOptional(p,'Position',[0.2 0.2 0.6 0.6])
            addOptional(p,'msg',[])
            addOptional(p,'CreateStruct',[])
            addOptional(p,'Tag',' ')
            addOptional(p,'Callback',' ')
            parse(p,varargin{:});
            
                        
            Parent       = p.Results.Parent;
            Position     = p.Results.Position;
            msg          = p.Results.msg;
            CreateStruct = p.Results.CreateStruct;
            Tag          = p.Results.Tag;
            Callback     = p.Results.Callback;
            
            import javax.swing.ImageIcon
        
            [obj.handle,obj.java] = uicomponent(javax.swing.JButton,'Parent',Parent);
            obj.handle.Units='normalize';
            obj.handle.Position = Position;
            obj.handle.Tag   = Tag;
            obj.handle.ToolTipText = 'Minus';
            obj.handle.MouseClickedCallback = Callback;
            obj.java.setBorderPainted(false);
            try
                [X,map] = imread('navindoor-source/src/GUI/imgs/minus.png','Background',[0.9400 0.9400 0.9400]);
            catch 
                [X,map] = imread('navindoor-source/src/GUI/imgs/minus.png');
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

