function [ h ] = drawArrow( x,y,varargin)


h = annotation('arrow');
set(h, ...
    'position', [x(1),y(1),x(2)-x(1),y(2)-y(1)], ...
    'HeadLength', 7, 'HeadWidth', 10, ...
    varargin{:} );

end
