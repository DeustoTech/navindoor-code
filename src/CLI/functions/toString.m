function result = toString(iclass)

    console = evalc('iclass');
    console = split((console),'properties:');
    console = console{2};
    result = strip(strsplit(strip(console),'\n'));
    
end
