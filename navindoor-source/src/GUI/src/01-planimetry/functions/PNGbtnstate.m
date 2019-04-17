function PNGbtnstate(h,state)
%%
png_file          = findobj_figure(h.iur_figure,'Planimetry','PNG File'); 
%%
pngfile_edit      = findobj_figure(png_file,'path');
png_edit      = findobj_figure(png_file,'btnedit');

pngfile_load      = findobj_figure(png_file,'btnload');
pngfile_ok        = findobj_figure(png_file,'btnok');
pngfile_remove    = findobj_figure(png_file,'btnremove');
slider            = findobj_figure(png_file,'Angle');



switch state 
    case 'empty'
        pngfile_edit.String = {};
        pngfile_ok.Enable       = 'Off';
        pngfile_edit.Enable     = 'Off';
        png_edit.Enable         = 'Off';
        pngfile_remove.Enable   = 'Off';
        pngfile_load.Enable     = 'On';
        slider.Enable           = 'Off';
    case 'edit'
        pngfile_ok.Enable       = 'On';
        pngfile_edit.Enable     = 'Off';
        png_edit.Enable         = 'Off';
        pngfile_remove.Enable   = 'Off';
        pngfile_load.Enable     = 'Off'; 
        slider.Enable           = 'On';
    case 'hold'
        pngfile_ok.Enable       = 'Off';
        pngfile_edit.Enable     = 'On';
        pngfile_remove.Enable   = 'On';
        pngfile_load.Enable     = 'On';
        png_edit.Enable         = 'On';
        slider.Enable           = 'Off';
end
end

