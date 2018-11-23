classdef msgbox_iur
    %MSGBOX_IUR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        figure
    end
    
    methods
        function obj = msgbox_iur(msg,title,varargin)
            %MSGBOX_IUR Construct an instance of this class
            %   Detailed explanation goes here
            
            p = inputParser;
            addRequired(p,'title')
            addRequired(p,'msg')
            addOptional(p,'Position',[0.4 0.4 0.2 0.2])
            
            parse(p,msg,title,varargin{:})
            
            Position = p.Results.Position;
            
            current = gcf;

            obj.figure = figure('Units','normalized','Position',Position);
            obj.figure.ToolBar = 'none';
            obj.figure.MenuBar = 'none';
            obj.figure.Name = title;
            obj.figure.NumberTitle = 'off';
            obj.figure.KeyPressFcn = @keypress;
            obj.figure.WindowStyle = 'modal';
            
            
            uicontrol('style','text','String',msg, ...
                      'Units','normalized',        ...
                      'FontSize',12,               ...
                      'Position',[0.1 0.4 0.8 0.4])
            
            uicontrol('style','pushbutton', ...
                      'Parent',obj.figure,  ...
                      'Units','normalized', ...
                      'Position',[0.4 0.1 0.2 0.2], ...
                      'String','Ok','Callback',{@(object,event,h) delete(h),obj.figure})
            
            set(0, 'currentfigure', current);  
            
            function keypress(object,event)
                if strcmp(event.Key,'return')
                    delete(object)
                end
            end
        end
        

    end
end

