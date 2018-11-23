function object = findobj_figure(object,varargin)

    len = length(varargin);

    for index =  1:len
        property = 'Tag';
        value    = varargin{index};
        object = findobj(object,property,value);
    end

end
