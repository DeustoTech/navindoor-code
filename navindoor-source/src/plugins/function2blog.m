function function2blog(path_function,outpath)
%FUNCTION2BLOG Summary of this function goes here
%   Detailed explanation goes here
    [ ~ , result ] = system(['cat ',path_function,'|grep ''addRequired''']);
    result = strtrim(result);
    result = splitlines(result)

    

    [ ~ , result ] = system(['cat ',path_function,'|grep ''addOptional''']);
    result = strtrim(result);
    result = splitlines(result)
    
end

