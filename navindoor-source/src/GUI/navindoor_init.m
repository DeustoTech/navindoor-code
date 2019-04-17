function navindoor_init(mapfile)

    h = iur_handles;
    h.planimetry_layer = planimetry_layer;
    h.planimetry_layer.mapfile = mapfile;
    h.planimetry_layer.osm = Osm(mapfile);
    
    h.navindoor_path  = replace(which('StartNavindoor.m'),'StartNavindoor.m','');

    h.path  = replace(which('navindoor.m'),'navindoor.m','');
    h.path  =  h.path(1:(end-1));
    % Create Openning JFrame, to show the name of framework.
    
    h.openning_box = javax.swing.JFrame;
    h.openning_box.setSize(400,150);
    h.openning_box.setLocationRelativeTo([]);
    h.openning_box.setUndecorated(true);
    h.openning_box.setOpacity(0.8);
    
    JLabel = javax.swing.JLabel;
    
    logo_path = fullfile(h.path,'imgs','logo_small.png');

    [X,map] = imread(logo_path,'Background',[0.9400 0.9400 0.9400]);

    JLabel.setIcon(javax.swing.ImageIcon(im2java(X)));
    h.openning_box.add(JLabel);
    h.openning_box.setVisible(true);

    try 
        h.iur_figure = figure('Name','navindoor',  ...
                              'NumberTitle','off',       ...
                              'Units', 'normalize',      ...
                              'Position', [0.005 0.05 0.945 0.85],     ...
                              'Visible','off',           ...
                              'KeyPressFcn',{@keyboard_callback,h},     ...
                              'MenuBar','none');

        h.zoom_iurfigure =  zoom(h.iur_figure);
        h.pan_iurfigure = pan(h.iur_figure);
        % Create the h struture, where  will saved, all vars of applications


        % ==================
        %  strucutre that contains al information of planimetry
        h.trajectory_layer = trajectory_layer.empty;

        graph_iur(h);

        h.openning_box.setVisible(false);

        h.iur_figure.Visible = 'on';
    catch err
        h.openning_box.setVisible(false);    
        err.getReport
    end
    'iur';

