classdef TableOfObjects
    %TABLEOFOBJECTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        object
        figure
    end
    
    methods
        function obj = TableOfObjects(object)
           obj.figure = figure_empty;
           FontPanel  = 'Comic Sans MS';
           obj.figure.WindowStyle = 'modal';
           set(obj.figure,'defaultuicontrolFontSize',13)
           set(obj.figure,'defaultuicontrolFontSize',13)
           set(obj.figure,'defaultuicontrolFontName',FontPanel)
           set(obj.figure,'defaultuitableFontName',FontPanel)

           obj.object = object;
           
           %% figure
           [left_panel,right_panel,hDiv] = uisplitpane(obj.figure,'Orientation','horizontal','DividerLocation',0.25,'DividerColor',[0.6 0.6 0.6]);

            
            %% Left
                % Info Main Object
                inf_obj = uipanel('Parent',left_panel,'Title','Info Main Object','Units','normalized','Position',[0.0 0.5 1.0 0.5]);
                info_panel(inf_obj)
                %
                meta_object = metaclass(object);
                %
                edit_Class = findobj_figure(inf_obj,'Class');
                edit_Class.String = meta_object.Name;
                %
                edit_Label = findobj_figure(inf_obj,'Label');
                edit_Label.String = object.label;
                % 
                edit_description = findobj_figure(inf_obj,'Description');
                [out, ~] = help(meta_object.Name);
                Description = split(out,'***');
                if length(Description) > 1
                    Description = Description{3};    
                else
                    Description = 'MATLAB Object';
                end                
                edit_description.String = Description;
                
                inf_prop = uipanel('Parent',left_panel,'Title','Info of Select Property','Units','normalized','Position',[0.0 0.0 1.0 0.5]);
                info_panel_prop(inf_prop)
                % Info first Object
                subobject = get(object,meta_object.PropertyList(1).Name);
                meta_object_first_property = metaclass(subobject);
                
                edit_Class = findobj_figure(inf_prop,'Class');
                edit_Class.String = meta_object_first_property.Name;
            
                % 
                edit_description = findobj_figure(inf_prop,'Description');
                [out, ~] = help(meta_object_first_property.Name);
                Description = split(out,'***');
                if length(Description) > 1
                    Description = Description{3};    
                else
                    Description = 'MATLAB Object';
                end
                
            %% right
            table = uitable('Parent',right_panel,'Units','normalized','Position',[0 0 1 1],'Tag','table');
             jscrollpane = findjobj(table);
             jviewport = jscrollpane.getViewport;
             jtable = jviewport.getView;
             set(jtable, 'MouseClickedCallback',{@clicktableCallback,obj});
            table.FontSize = 12;
            table.RowName = '';
            right_panel.Units = 'pixels';
            width_pixels = right_panel.OuterPosition(3);
            right_panel.Units = 'normalized';
            
            table.ColumnWidth = {0.20*width_pixels 0.15*width_pixels  0.45*width_pixels  0.2*width_pixels};
            table.ColumnName = {'Property','Class','Description','Value'};
            
            update_table
            %%
            %%
            %%
            %%
            function info_panel(ipanel)
                %% Text uicontrols
                x = 0.3; h = 0.075; w = 0.15;y = 0.8;
               
                uicontrol('style','text','Parent',ipanel,'String','Class:','Units','normalized','Position',[x-w y w h])
                w = 0.15;
                y = 0.7;               
                uicontrol('style','text','Parent',ipanel,'String','Label:','Units','normalized','Position',[x-w y w h])
                w = 0.25;
                y = 0.6;               
                uicontrol('style','text','Parent',ipanel,'String','Description:','Units','normalized','Position',[x-w y w h])
                %% Edit uicontrols
                x = 0.95;h = 0.075;w = 0.6;
                
                y = 0.8;
                uicontrol('style','text','Parent',ipanel,'String','Class','Units','normalized','Position',[x-w y w h],'BackgroundColor',[0.8 0.8 0.8],'Tag','Class')
                y = 0.7;               
                uicontrol('style','text','Parent',ipanel,'String','Label','Units','normalized','Position',[x-w y w h],'BackgroundColor',[0.8 0.8 0.8],'Tag','Label')
                y = 0.1;  
                h = 0.575;
                uicontrol('style','text','Parent',ipanel,'String','Description','Units','normalized','Position',[x-w y w h],'BackgroundColor',[0.8 0.8 0.8],'Tag','Description','HorizontalAlignment','left')
                
            end
            function info_panel_prop(ipanel)
                %% Text uicontrols
                x = 0.3; h = 0.075; w = 0.15;y = 0.8;
               
                uicontrol('style','text','Parent',ipanel,'String','Class:','Units','normalized','Position',[x-w y w h])
                w = 0.25;
                y = 0.7;               
                uicontrol('style','text','Parent',ipanel,'String','Description:','Units','normalized','Position',[x-w y w h])
                %% Edit uicontrols
                x = 0.95;h = 0.075;w = 0.6;
                
                y = 0.8;
                uicontrol('style','text','Parent',ipanel,'String','Class','Units','normalized','Position',[x-w y w h],'BackgroundColor',[0.8 0.8 0.8],'Tag','Class')
                y = 0.1;  
                h = 0.675;
                uicontrol('style','text','Parent',ipanel,'String','Description','Units','normalized','Position',[x-w y w h],'BackgroundColor',[0.8 0.8 0.8],'Tag','Description','HorizontalAlignment','left')
                                
            end
            function update_table()
                table.Data = [];
                table.Data = cell(length(meta_object.PropertyList),4);
                values = toString(object);
                for index_property =  1:length(meta_object.PropertyList)
                    subobject = get(object,meta_object.PropertyList(index_property).Name);
                    meta_object_first_property = metaclass(subobject);
                    % Name Property
                    table.Data{index_property,1} = ['<html><b style="color:#990000";>',meta_object.PropertyList(index_property).Name,'</b></html>'];
                    % Class Property
                    table.Data{index_property,2} = ['<html><p style="color:#003593";>',meta_object_first_property.Name,'</p></html>'];
                    % Description
                    Description = help([class(object),'.',meta_object.PropertyList(index_property).Name]);
                    Description = split(Description,'-');

                    if length(Description) > 1
                        Description = Description{2};
                        Description = split(Description,'***');
                        if length(Description) > 1
                            table.Data{index_property,3} = Description{2}(1:end-1);
                        else
                            table.Data{index_property,3} = Description{:};
                        end
                    else
                        table.Data{index_property,3} = '-';
                    end
                    % Value 
                    data = split(values{index_property},':');
                    table.Data{index_property,4} = data{2};
                end   
            end
            
            function clicktableCallback(object,event,h)
                persistent chk
                if isempty(chk)
                      chk = 1;
                      pause(0.25); %Add a delay to distinguish single click from a double click
                      if chk == 1
                          chk = [];
                      end
                else
                    chk = [];
                    nrow = object.getSelectedRow + 1;
                    meta_class = metaclass(h.object);
                    description = help([class(h.object),'.',meta_class.PropertyList(nrow).Name]);
                    description = split(description,'***');
                    description = split(description{1},' - ');
                    
                    if length(description) > 1
                        name = strtrim(description{1});
                        func = strtrim(description{2});
                        if strcmp(func(1),'@')
                            func = str2func(func(2:end));
                            value = get(h.object,meta_class.PropertyList(nrow).Name);
                            result = func(name,value);
                            waitfor(result.fig)
                            set(h.object,name,result.h);
                            update_table
                        end
                    end
                end
            end
        end
    end
end

