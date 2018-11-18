function CT02_panel_tools(h,panel_tools)
%CT01_PANEL_TOOLS Summary of this function goes here
%   Detailed explanation goes here

import javax.swing.SwingConstants
import javax.swing.JToggleButton
import javax.swing.ImageIcon
import javax.swing.ButtonGroup

[~ ,path] = system('pwd | sed ''s/ /\\ /g''');
path = strtrim(path);

[hgroup , jgroup]= uicomponent('style'     ,   'JToolBar',   ...
                               'Parent'    ,   panel_tools,  ...
                               'Units'     , 'normalize');

jgroup.setOrientation(SwingConstants.VERTICAL);
hgroup.Position = [0 0 1 1];

% ====================================================================================
vertex = create_button('vertex');
vertex.setSelected(true);

% ====================================================================================
insert = create_button('insert');
insert.setSelected(true);

select = create_button('select');
hand = create_button('hand');
zoomplus = create_button('zoomplus','TipText','Zoom in');
zoomminus = create_button('zoomminus','TipText','Zoom out');
% ====================================================================================

%jgroup.add(vertex);
%jgroup.addSeparator();

jgroup.add(insert);
%jgroup.add(select);
jgroup.add(hand);
jgroup.add(zoomplus);
jgroup.add(zoomminus);

% 
% h.javacomponets.trajectory_layer.btngrp_mode  = ButtonGroup;
% h.javacomponets.trajectory_layer.btngrp_mode.add(vertex);

% ==================================================================
h.javacomponets.trajectory_layer.btngrp_option  = ButtonGroup;

    h.javacomponets.trajectory_layer.btngrp_option.add(insert);
    h.javacomponets.trajectory_layer.btn_insert = insert;
    j  = handle(h.javacomponets.trajectory_layer.btn_insert,'CallbackProperties');
    j.MouseClickedCallback  = {@btn_insert_planimetry,h};

%     h.javacomponets.trajectory_layer.btngrp_option.add(select);
%     h.javacomponets.trajectory_layer.btn_select = select;
%     j  = handle(h.javacomponets.trajectory_layer.btn_select,'CallbackProperties');
%     j.MouseClickedCallback  = {@btn_select_planimetry,h};
    
    h.javacomponets.trajectory_layer.btngrp_option.add(hand);
    h.javacomponets.trajectory_layer.btn_hand = hand;
    j  = handle(h.javacomponets.trajectory_layer.btn_hand,'CallbackProperties');
    j.MouseClickedCallback  = {@btn_hand_planimetry,h};
    
    h.javacomponets.trajectory_layer.btngrp_option.add(zoomplus);
    h.javacomponets.trajectory_layer.btn_zoomplus = zoomplus;
    j  = handle(h.javacomponets.trajectory_layer.btn_zoomplus,'CallbackProperties');
    j.MouseClickedCallback  = {@btn_zoomplus_planimetry,h};
    
    h.javacomponets.trajectory_layer.btngrp_option.add(zoomminus);
    h.javacomponets.trajectory_layer.btn_zoomminus = zoomminus;
    j  = handle(h.javacomponets.trajectory_layer.btn_zoomminus,'CallbackProperties');
    j.MouseClickedCallback  = {@btn_zoomminus_planimetry,h};

end

