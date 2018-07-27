function CT05_panel_compare(h,panel_compare)
%CT05_PANEL_COMPARE Summary of this function goes here
%   Detailed explanation goes here
    uicontrol('style','pushbutton','String','Go!','Parent',panel_compare,'Units','normalized','Position',[0.3 0.35 0.4 0.3],'Callback',{@go_comparison_callback,h})
end

