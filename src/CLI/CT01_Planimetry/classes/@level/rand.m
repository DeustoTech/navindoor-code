function result = rand(level,class)
    if nargin < 2
        class = 'node';
    end
    fun=str2func(class);

    x = rand*(level.dimensions(1)-5);
    y = rand*(level.dimensions(2)-5);
    result = fun([x y]);

end