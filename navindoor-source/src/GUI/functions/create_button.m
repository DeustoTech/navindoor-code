function button = create_button(name,varargin)

    p = inputParser;
    addRequired(p,'name')
    addOptional(p,'TipText',name)
    
    parse(p,name,varargin{:})
    
    TipText = p.Results.TipText;
    
    import javax.swing.ImageIcon

    button       = javax.swing.JToggleButton('');
    button.setActionCommand(name)
    button.setToolTipText(name);
    
    try
        [X,map] = imread(['navindoor-source/src/GUI/navindoor/imgs/',name,'.png'],'Background',[0.9400 0.9400 0.9400]);
    catch 
        [X,map] = imread(['navindoor-source/src/GUI/navindoor/imgs/',name,'.png']);
    end
    if ~isempty(map)
        button.setIcon(ImageIcon(im2java(X,map)));
    else
        button.setIcon(ImageIcon(im2java(X)));
    end

    
end
