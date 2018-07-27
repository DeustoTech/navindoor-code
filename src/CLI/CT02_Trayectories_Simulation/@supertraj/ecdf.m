function ecdf(straj,esti_strajs,varargin)

    
%ECDF Summary of this function goes here
%   Detailed explanation goes here
    p  = inputParser;
    addRequired(p,'straj')
    addRequired(p,'esti_strajs')
    addOptional(p,'Parent',[])
    
    parse(p)
    
    Parent = p.Results.Parent;
    if isempty(Parent)
        figure()
        Parent = gca;
    end

    for esti_straj = esti_strajs
        list_error = error([straj esti_straj]);
        hold on
        [A,B] = ecdf(list_error);        
        Parent.XLabel = '[m]';
        Parent.YLabel ='Cumulative Distribution';
        plot(B,A,'Parent',Parent)
    end
    labels = {esti_strajs.label};
    index = 0;
    for label = labels
        index = index + 1;
        if isempty(label{:})
            labels{index} = 'no label';
        end
    end
    legend(labels)
    Parent.Title = 'Cumulative Distribution';

end

