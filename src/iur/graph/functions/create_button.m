function button = create_button(name)
    import javax.swing.ImageIcon

    button       = javax.swing.JToggleButton("");
    button.setActionCommand(name)
    button.setToolTipText(name);
    
    try
        [X,map] = imread(['src/iur/imgs/',name,'.png'],'Background',[0.9400 0.9400 0.9400]);
    catch 
        [X,map] = imread(['src/iur/imgs/',name,'.png']);
    end
    if ~isempty(map)
        button.setIcon(ImageIcon(im2java(X,map)));
    else
        button.setIcon(ImageIcon(im2java(X)));
    end

end
