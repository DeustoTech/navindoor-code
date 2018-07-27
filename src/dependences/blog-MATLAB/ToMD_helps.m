function ToMD_helps(all,CT,S,T)

 
[~ , answer] = system('find helps/* -name "help*"');
answer = splitlines(answer);

hexo_path ='/Users/jesusoroya/Documents/GitHub/Navindoor-Documentation/source/';
for index = 1:length(answer)
    example_script = answer{index};
    if isempty(example_script)
        continue
    end
    aux_cell = split(example_script,'/');

    path = aux_cell{2};
    % asignacion de propiedades del ejemplo
    category = aux_cell{2}; category = replace(category,'_',' ');
    name_with_slash =  aux_cell{3};name_with_slash = name_with_slash(1:end-2); 
    name = replace(name_with_slash,'_',' ');
    if all
        if ~strcmp(category(1:4),CT)
            continue
        elseif ~strcmp(subcategory(1:3),S)
            continue
        elseif ~strcmp(name(1:3),T)
            continue
        end
    end
    [path,'/',name]
    save('ToMD_workspace');
    %% Script MATLAB to MarkDown
    publishreadme(aux_cell{4}(1:end-2),['helps/',path,'/',aux_cell{3}],false);
    %publishjekyllpost([name_with_slash,'.m'],['examples/',path],false);
    clear;
    load('ToMD_workspace');
    % borramos html 
    delete(['helps/',path,'/',aux_cell{3},'/',aux_cell{4}]);

    path_imgs = [hexo_path,'images/',path];
    system(['mkdir -p ',path_imgs]);
    
    if exist(['examples/',path,'/readmeExtras'],'dir') ~= 0 % si existe algo que copiar, imagenes
        system(['cp examples/',path,'/readmeExtras/* ',path_imgs,'/.']);
    end
    
    path_imgs = replace(path_imgs,'/','\/');
    path_imgs_in_hexo = ['/images/',path];
    
    path_imgs_in_hexo = replace(path_imgs_in_hexo,'/','\/');

    path_posts = [hexo_path,'_posts/functions/',path,'/'];
    system(['mkdir -p ',path_posts]);
    ID = [category(1:4),'_',name(1:3)];

    namemd = [path_posts,replace(name,' ','_'),'.md'];
    system(['echo "title: ',name,'"',' > ',namemd]);
    system(['echo "categories: [\"','Functions','\",\"',category,'\"]"',' >> ',namemd]);
    system(['echo "ArticleID: ',ID,'" >> ',namemd]);
    system(['echo "---"',' >> ',namemd]);
    system(['cat ',example_script,'d','| awk "NR != 1" |awk "NR != 1"','|sed "s/.\/readmeExtras\//',path_imgs_in_hexo,'\/','/g"',' >> ',namemd]);
    
    % tables 
    script_tables = '/Users/jesusoroya/Documents/GitHub/DeustoTech-PIBA-BLUE/navindoor/src/hexo/gotable_matlab2hexo.sh';
    system(['sh ',script_tables,' ',namemd]);
    system(['mv output.txt ',namemd]);

    % borramos figuras y markdowns
    delete(['examples/',path,'/',replace(name,' ','_'),'.md']);
    if exist(['examples/',path,'/readmeExtras'],'dir') ~= 0 % si existe algo que copiar, imagenes
        system(['rm -r examples/',path,'/readmeExtras']);
    end
    
end

system('rm TOMD_workspace.mat');
