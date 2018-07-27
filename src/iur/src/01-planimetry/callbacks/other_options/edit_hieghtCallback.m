function edit_hieghtCallback(object,event,h)
%EDIT_HIEGHTCALLBACK Summary of this function goes here
%   Detailed explanation goes here


    input_hight = str2double(event.Source.String);

    tab_planimetry = findobj(h.iur_figure,'Title','Planimetry');
    control_panel  = findobj(tab_planimetry,'Title','Levels');
    list_box       = findobj(control_panel,'Style','listbox');
    index_level    = list_box.Value ;

    %% validations 


    if isnan(input_hight)
        msg = 'The Hieght property must be numeric';
        title = 'Var type';
        errordlg(msg,title);
        % reescribimos el valor que tenia antes
        object.String = num2str(h.planimetry_layer(index_level).hieght);
        return
    end

    if index_level > 1
        % La lista  boolean_list deberá ser ceros, ya que estamos buscando alturas mayores 
        % en niveles mas bajos 
        boolean_list = [h.planimetry_layer(1:index_level-1).hieght] > input_hight;
        % la suma de esta lista debe ser cero, ya que no puede haber ningun nivel 
        % anterior 
        if sum(boolean_list) > 0
            title = 'Hieght Property of Level';
            msg = 'A level lower, can not be grather hight.';
            errordlg(msg,title);
            % reescribimos el valor que tenia antes
            object.String = num2str(h.planimetry_layer(index_level).hieght);

            return
        end
    end


    h.planimetry_layer(index_level).hieght = input_hight;



end

