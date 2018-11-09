function CT01_panel_tools(h,panel_tools)
%CT01_PANEL_TOOLS Summary of this function goes here
%   Detailed explanation goes here

import javax.swing.SwingConstants
import javax.swing.JToggleButton
import javax.swing.ImageIcon
import javax.swing.ButtonGroup
import java.awt.Color;


import java.awt.Dimension;
 
import java.awt.Font;


[hgroup , jgroup]= uicomponent('style'     ,   'JToolBar',   ...
                               'Parent'    ,   panel_tools,  ...
                               'Units'     , 'normalize');

jgroup.setOrientation(SwingConstants.VERTICAL);
hgroup.Position = [0 0 1 1];

% ====================================================================================

nodes = create_button('nodes');
nodes.setSelected(true);
walls = create_button('walls');
doors = create_button('doors');
elevators = create_button('elevators');
stairs = create_button('stairs');
connections = create_button('connections');
beacons = create_button('beacons');


% ====================================================================================
insert = create_button('insert');
insert.setSelected(true);

select = create_button('select');
hand = create_button('hand');
zoomplus = create_button('zoomplus','TipText','Zoom in');
zoomminus = create_button('zoomminus','TipText','Zoom out');

% ====================================================================================
iFont = Font("SansSerif", Font.PLAIN, 10);

[textField ,  htextField_elements]= uicomponent('style','JTextField','Text','Elements','BackgroundColor',[0.9400 0.9400 0.9400]);
htextField_elements.setEditable(false)
htextField_elements.setFont(iFont)
htextField_elements.setBackground(Color(0.9400,0.9400,0.9400))


jgroup.add(htextField_elements);

jgroup.add(nodes);
jgroup.add(walls);
jgroup.add(doors);
jgroup.add(elevators);
jgroup.add(stairs);
jgroup.add(connections);
jgroup.add(beacons);

jgroup.addSeparator();

[textField ,  htextField_actions]= uicomponent('style','JTextField','Text','Actions','BackgroundColor',[0.9400 0.9400 0.9400]);
htextField_actions.setEditable(false)
htextField_actions.setFont(iFont)
htextField_actions.setBackground(Color(0.9400,0.9400,0.9400))
jgroup.add(htextField_actions);

jgroup.add(insert);
jgroup.add(select);
jgroup.add(hand);
jgroup.add(zoomplus);
jgroup.add(zoomminus);


h.javacomponets.planimetry_layer.btngrp_mode  = ButtonGroup;
h.javacomponets.planimetry_layer.btngrp_mode.add(nodes);
h.javacomponets.planimetry_layer.btngrp_mode.add(walls);
h.javacomponets.planimetry_layer.btngrp_mode.add(doors);
h.javacomponets.planimetry_layer.btngrp_mode.add(elevators);
h.javacomponets.planimetry_layer.btngrp_mode.add(stairs);
h.javacomponets.planimetry_layer.btngrp_mode.add(connections);
h.javacomponets.planimetry_layer.btngrp_mode.add(beacons);
% ==================================================================
h.javacomponets.planimetry_layer.btngrp_option  = ButtonGroup;

    % ==================================================================
    
    h.javacomponets.planimetry_layer.btngrp_option.add(insert);
    h.javacomponets.planimetry_layer.btn_insert = insert;
    % planimetry_layer and trajectory_layer have the same options tools
    j  = handle(h.javacomponets.planimetry_layer.btn_insert,'CallbackProperties');
    j.MouseClickedCallback  = {@btn_insert_planimetry,h};

    
    % ==================================================================
 
    h.javacomponets.planimetry_layer.btngrp_option.add(select);
    h.javacomponets.planimetry_layer.btn_select = select;
    % planimetry_layer and trajectory_layer have the same options tools
    j  = handle(h.javacomponets.planimetry_layer.btn_select,'CallbackProperties');
    j.MouseClickedCallback  = {@btn_select_planimetry,h};

    
    % ==================================================================
    
    h.javacomponets.planimetry_layer.btngrp_option.add(hand);
    h.javacomponets.planimetry_layer.btn_hand = hand;
    % planimetry_layer and trajectory_layer have the same options tools
    j  = handle(h.javacomponets.planimetry_layer.btn_hand,'CallbackProperties');
    j.MouseClickedCallback  = {@btn_hand_planimetry,h};

    
    % ==================================================================
    
    h.javacomponets.planimetry_layer.btngrp_option.add(zoomplus);
    h.javacomponets.planimetry_layer.btn_zoomplus = zoomplus;
    % planimetry_layer and trajectory_layer have the same options tools
    j  = handle(h.javacomponets.planimetry_layer.btn_zoomplus,'CallbackProperties');
    j.MouseClickedCallback  = {@btn_zoomplus_planimetry,h};

    
    % ==================================================================
    
    h.javacomponets.planimetry_layer.btngrp_option.add(zoomminus);
    h.javacomponets.planimetry_layer.btn_zoomminus = zoomminus;
    % planimetry_layer and trajectory_layer have the same options tools 
    j  = handle(h.javacomponets.planimetry_layer.btn_zoomminus,'CallbackProperties');
    j.MouseClickedCallback  = {@btn_zoomminus_planimetry,h};


end


