function keyboard_callback(object,event,h)

    %KEYBOARD_CALLBACK Summary of this function goes here
    %   Detailed explanation goes here
    switch event.Key
        case  'backspace'
            baskspace_callback(h)
        case 'rightarrow'
            arrows_callback(h,'rightarrow')
        case 'leftarrow'
            arrows_callback(h,'leftarrow')
        case 'uparrow'
            arrows_callback(h,'uparrow')
        case 'downarrow'
            arrows_callback(h,'downarrow')
    end
end

