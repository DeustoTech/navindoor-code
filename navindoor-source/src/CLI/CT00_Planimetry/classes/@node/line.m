function out = line(nodes,varargin)
% description: Draw the list of nodes in currently axes
% autor: JesusO
% MandatoryInputs:   
%   nodes: 
%    description: List of nodes
%    class: node
%    dimension: [1xN]
    mt = vec2mat([nodes.r],3);
    
    if ~isempty(varargin)
        boolean = arrayfun(@(index) strcmp(varargin{index},'Parent'),1:length(varargin));
        [~,index] = ismember(1,boolean);
        if index ~= 0
            Parent = varargin{index+1};
        else
            f = figure;
            Parent = axes('Parent',f);            
        end
    else
        f = figure;
        Parent = axes('Parent',f);
    end
    %%
    switch class(nodes)
        case 'elevator'
                pretex = ['ele-'];
        case 'stairs'
                pretex = ['sta-'];
        case 'beacon'
                pretex = ['L',num2str(nodes(1).level),'-'];
        otherwise
                pretex =''; 
    end
            %%
    
    i = 0;
    j = 0;
    select_graph_parameters = {'Marker','o','MarkerSize',16,'MarkerFaceColor','none','MarkerEdgeColor','red','LineWidth',1};
    if isempty(pretex) 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        out = gobjects(1,length(nodes));
        index_select = find([nodes.select] == 1);
        outs = gobjects(1,length(index_select));
        for inode = nodes
            i = i + 1;
            out(i) = line(inode.r(1),inode.r(2),varargin{:});
        end
        for idx = index_select
            j = j + 1;
            outs(j) = line(nodes(idx).r(1),nodes(idx).r(2),varargin{:},select_graph_parameters{:});
        end
        out = [out,outs];
    else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        out = gobjects(1,length(nodes));
        outt = gobjects(1,length(nodes));
        index_select = find([nodes.select] == 1);
        outs = gobjects(1,length(index_select));
        for inode = nodes
            i = i + 1;
            out(i) = line(inode.r(1),inode.r(2),varargin{:});
            outt(i) = text(mt(i,1)+1,mt(i,2),[pretex,num2str(i)],'FontSize',10,'Parent',Parent);
        end
        for idx = index_select
            j = j + 1;
            outs(j) = line(nodes(idx).r(1),nodes(idx).r(2),varargin{:},select_graph_parameters{:});
        end
        out = [out,outs,outt];

    end
        
        
end

