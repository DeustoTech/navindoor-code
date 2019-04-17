function EnableOnOff(listofelemets,OnOff)
% Habilita o desabilida todos los elementos de la lista de entrada
    for iobj =  listofelemets
        iobj{:}.Enable = OnOff;
    end
end