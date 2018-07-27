function result = atan_2pi(vector)
    
    if vector(1) == 0 && vector(2) == 0
       result = 0;
       return  
    end
    at = atan(vector(2)/vector(1));
    result = at;
    
    if vector(1) < 0 && vector(2) >= 0
        result = result + pi;
    elseif vector(1) < 0 && vector(2) < 0
        result = result + pi;
    elseif vector(1) >= 0 && vector(2) < 0
        result = result + 2*pi;
    end 
end
