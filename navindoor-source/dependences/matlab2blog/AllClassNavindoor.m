clear 
listofcategory = {'CLI/CT00_Planimetry/classes', ...
            'CLI/CT01-trajectories/classes', ...
            'CLI/CT02-signals/classes', ...
            'CLI/CT03-estimators/classes'};

        
for icategory = listofcategory
    category = icategory{:}
    category_data = what(category);
    category_path = category_data.path;

    classes_name = category_data.classes;


    for iclass = classes_name'
        matlabclass2blog(iclass{:},'/Users/jesusoroya/Documents/GitHub/navindoor-documentation/_posts/functions')
    end

end
