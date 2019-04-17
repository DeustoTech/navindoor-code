function ListBox_Navigation_InOut(object,event,h)


    delete(h.graphs_trajectory_layer.planimetry);

    Buildings_listbox   = h.DirectAccess.Trajectory.Navigation.Buildings;  
    Levels_listbox      = h.DirectAccess.Trajectory.Navigation.Levels;  
    
    switch object.String{object.Value}
        case '--In--'
            Buildings_listbox.Enable    = 'On';
            Levels_listbox.Enable       = 'On';
        case '-Out-'
            Buildings_listbox.Enable    = 'Off';
            Levels_listbox.Enable       = 'Off';
    end
    
        imap            = h.planimetry_layer.map;
        Parent          = h.DirectAccess.Trajectory.Axes;

        switch object.String{object.Value}
            case '--In--'
                IndexBuildings  = Buildings_listbox.Value;
                IndexLevels     = Levels_listbox.Value;
                Indexs = [IndexBuildings,IndexLevels];

                delete(h.graphs_trajectory_layer.planimetry);

                if ~isempty(imap.buildings(IndexBuildings).levels)
                    h.graphs_trajectory_layer.planimetry = plot(imap,'Indexs',Indexs,'Parent',Parent,'doors',false);
                else
                    h.graphs_trajectory_layer.planimetry = plot(imap,'Parent',Parent,'doors',false);
                end

            case '-Out-'
                Buildings_listbox.Enable    = 'Off';
                Levels_listbox.Enable       = 'Off';
                h.graphs_trajectory_layer.planimetry = plot(imap,'Parent',Parent,'doors',true);
        end
    
        update_trajectory_layer(h)

end

