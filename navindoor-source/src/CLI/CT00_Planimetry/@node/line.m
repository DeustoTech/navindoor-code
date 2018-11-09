function line(nodes,varargin)
%LINE Summary of this function goes here
%   Detailed explanation goes here
    mt = vec2mat([nodes.r],3);
    
    
    boolean = arrayfun(@(index) strcmp(varargin{index},'Parent'),1:length(varargin));
    [~,index] = ismember(1,boolean);
    Parent = varargin{index+1};
    
    i = 0;
    for inode = nodes
        i = i + 1;
            switch class(inode)
                case 'elevator'
                        text(mt(i,1)+1,mt(i,2),['ele-',num2str(i)],'FontSize',10,'Parent',Parent);
                case 'stairs'
                        text(mt(i,1)+1,mt(i,2),['sta-',num2str(i)],'FontSize',10,'Parent',Parent);
                case 'beacon'
                        text(mt(i,1)+1,mt(i,2),['L',num2str(inode.level),'-AP-',num2str(i)],'FontSize',10,'Parent',Parent);

            end
            line(inode.r(1),inode.r(2),varargin{:})
            
        if inode.select
            line(inode.r(1),inode.r(2),varargin{:},'Marker','o','MarkerSize',15,'MarkerFaceColor','none','MarkerEdgeColor','red','LineWidth',1)
        end
    end
end

