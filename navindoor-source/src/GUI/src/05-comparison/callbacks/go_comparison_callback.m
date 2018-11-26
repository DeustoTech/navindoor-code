function go_comparison_callback(object,event,h)
%GO_COMPARISON_CALLBACK Summary of this function goes here
%   Detailed explanation goes here

 %% Graph
panel_error_time = findobj_figure(h.iur_figure,'Methods Comparison','Graphs','Error in Time');delete(panel_error_time.Children)
axes_error = axes('Parent',panel_error_time);
axes_error.XLabel.String = 't(s)';
axes_error.YLabel.String = 'Error(m)';
%
panel_ecdf_time = findobj_figure(h.iur_figure,'Methods Comparison','Graphs','Cumulative Distribution');delete(panel_ecdf_time.Children)
axes_ecdf = axes('Parent',panel_ecdf_time);
axes_ecdf.XLabel.String = 'distance(m)';
axes_ecdf.YLabel.String = 'Cumulative Probability';
axes_ecdf.XGrid ='on';
axes_ecdf.YGrid ='on';
axes_ecdf.FontSize = 16;


%% Index Supertraj
listbox_supertraj = findobj_figure(h.iur_figure,'tabgroup','Methods Comparison','Supertraj','listbox');
index_straj = listbox_supertraj.Value;
    

jCBList = h.AvailableTraj(index_straj).jCBList;
 list_estimators = h.AvailableTraj(index_straj).aviable_estimators((jCBList.getCheckedIndicies + 1)');
 labels = {};
 index = 0;
 list_colors = {'r','g','b','y','c','k'};
 
 
 
 
 for iestimator = list_estimators
     index = index + 1;
     labels{index} = iestimator.label;
     color = list_colors{mod(index,length(list_colors))+ 1};
     line(iestimator.error(:,1),iestimator.error(:,2),'Parent',axes_error,'Color',color)
     
     line(iestimator.ecdf.B,iestimator.ecdf.A,'Parent',axes_ecdf,'Color',color)

 end
 legend(axes_error,labels)
  legend(axes_ecdf,labels)
  
end

