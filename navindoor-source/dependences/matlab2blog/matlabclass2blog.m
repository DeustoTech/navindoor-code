function matlabclass2blog(ClassName,FolderDocumentation)
    
    data_class = what(ClassName);
    path_class = data_class.path;

    mfiles = data_class.m;

    mkdir([FolderDocumentation,'/',ClassName])
    
    FolderDocumentation = [FolderDocumentation,'/',ClassName];
    %% Contructor 

    mfile_path = [path_class,'/',ClassName,'.m'];
    help_data = ObtainHelp(mfile_path);
    metadata = metaclass(eval([ClassName,'.empty']));    
    
    %% Properties 
    sp = '   ';
    listofproperties = ['properties:',newline];
    for ipl = metadata.PropertyList'
                if strcmp(ipl.Name,'select')
           continue 
        end
        if ~strcmp(ipl.DefiningClass.Name,ClassName)
            continue
        end
        listofproperties = [listofproperties,sp,ipl.Name,': ',newline];

        help_property = replace(strtrim(help([ClassName,'.',ipl.Name])),newline,' ');
        help_property = strsplit(help_property,'-');
        help_property = help_property{2};
        listofproperties = [listofproperties,sp,sp,'description: ',help_property,'',newline];
        listofproperties = [listofproperties,sp,sp,'type: ',help_property,'',newline];
        
        if ipl.HasDefault
           text_default = evalc('ipl.DefaultValue');
           text_default = strsplit(strtrim(text_default),newline);
           text_default = strtrim(text_default{end});
           
           listofproperties = [listofproperties,sp,sp,'default: ',text_default,newline];
        end
    end    
    listofproperties = replace(listofproperties,'%',' ');
    %%
    listofmethods = ['methods:',newline];
    for ipl = metadata.MethodList'
        if strcmp(ipl.DefiningClass.Name,ClassName) && ~strcmp(ipl.Name,'empty')
        listofmethods = [listofmethods,sp,ipl.Name,':',newline];
        helptext = ObtainHelp([ClassName,'/',ipl.Name]);
        listofmethods = strtrim([listofmethods,sp,sp,'description: ',helptext,'',newline]);
        listofmethods = [listofmethods,newline];
        end
    end
    listofmethods = strtrim(listofmethods);
    
    %% HELP file
    
    help_mfile = ['helpfile_',ClassName];
    if exist([help_mfile,'.m'],'file')
        publishreadme(help_mfile,data_class(2).path,true)

        md = fopen([data_class(2).path,'/',help_mfile,'.md'],'r');
        mdcontent = fscanf(md,'%c');

        fclose(md)
    end
    %% Load File
    outfile_path = [FolderDocumentation,'/0001-01-01-',ClassName,'.md'];
    if exist(outfile_path,'file')
       delete(outfile_path);
    end
    %% Get categories 
    categories = strsplit(path_class,'/');
    categories = categories{end-2};
    categories = strsplit(categories,'_');
    categories = categories{1}; 
    %%
    outfile_constructor = fopen(outfile_path,'a');
    
    fprintf(outfile_constructor,'---\n');
    fprintf(outfile_constructor,['description: ',help_data,'\n']);
    fprintf(outfile_constructor,['CT: ',categories]);

    fprintf(outfile_constructor,'\n');
    fprintf(outfile_constructor,'layout: class\n');
    fprintf(outfile_constructor,'type: constructor\n');
    fprintf(outfile_constructor,listofproperties);
    fprintf(outfile_constructor,listofmethods);
    fprintf(outfile_constructor,'\n---\n');
    if exist([help_mfile,'.m'],'file')
        fprintf(outfile_constructor,mdcontent);
    end
    fclose(outfile_constructor);
    
    
    
    
    %%
    
    for imfile  = mfiles'
        if strcmp(imfile{:}(1:(end-2)),ClassName) % is the constructor
            continue
        end
        mfile_path = [path_class,'/',imfile{:}];
        help_data  = ObtainHelp(mfile_path);
    end
end


function HelpText = ObtainHelp(path_file)

    help_data   = help(path_file);
    help_data = strsplit(help_data,'Reference page');
    HelpText = strtrim(help_data{1});
    HelpText = join(strtrim(strsplit(HelpText,'\n')),newline);
    
    HelpText= HelpText{:};
    HelpText = replace(HelpText,newline,' ');
end
