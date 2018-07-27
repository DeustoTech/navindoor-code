function h = iur
    h = iur_handles;

    h.openning_box = javax.swing.JFrame;
    h.openning_box.setSize(400,150);
    h.openning_box.setLocationRelativeTo([]);
    h.openning_box.setUndecorated(true);
    h.openning_box.setOpacity(0.8);
    
    JLabel = javax.swing.JLabel;
    
    logo_path = 'src/iur/imgs/logo_small.png';

    [X,map] = imread(logo_path,'Background',[0.9400 0.9400 0.9400]);

    JLabel.setIcon(javax.swing.ImageIcon(im2java(X)));
    h.openning_box.add(JLabel);
    pause(0.5)
    h.openning_box.setVisible(true);

    try

    
    h.iur_figure = figure('Name','iur - Navindoor',  ...
                          'NumberTitle','off',       ...
                          'Units', 'normalize',      ...
                          'Position', [0 0 1 1],     ...
                          'Visible','off',           ...
                          'MenuBar','none');

    h.zoom_iurfigure =  zoom(h.iur_figure);
    h.pan_iurfigure = pan(h.iur_figure);
    % Create the h struture, where  will saved, all vars of applications

    %% planimetry layer 
    % ==================
    %  strucutre that contains al information of planimetry
    h.planimetry_layer = planimetry_layer;
    %% trajectory layer 
    % ==================
    %  strucutre that contains al information of planimetry
    h.trajectory_layer = trajectory_layer;
    %% Signal Generation Layer
    % ==================

    %h.signal_layer = signal_layer;
    %% Signal Processing Layer
    % ==================
    %%h.processing_layer = processing_layer;
    
    graph_iur(h);
    
    pause(1.5)
    h.openning_box.setVisible(false);

    h.iur_figure.Visible = 'on';
    catch err
        h.openning_box.setVisible(false);    
        err.getReport
    end
    'iur';

