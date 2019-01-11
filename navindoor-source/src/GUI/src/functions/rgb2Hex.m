function hexStr = rgb2Hex( rgbColour )
hexStr = reshape( dec2hex( rgbColour, 2 )',1, 6);
