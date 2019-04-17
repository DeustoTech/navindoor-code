function  EditPicture(h,vb)
%FUNCTIONEDITPICTURE Summary of this function goes here
%   Detailed explanation goes here

         %% Pasamos la clase picture a slider para que pueda girar el objecto
         slider = findobj_figure(h.iur_figure,'PNG File','Angle');
         slider.Callback{2} = vb.picture_level.picture;
         %% bloqueamos las demas objectos exepto ok
         
         listOfObjects{1} = findobj_figure(h.iur_figure,'Planimetry','Levels','Height');
         listOfObjects{2} = findobj_figure(h.iur_figure,'Planimetry','Levels','listbox');
         listOfObjects{3} = findobj_figure(h.iur_figure,'Planimetry','Buildings','listbox');

         EnableOnOff(listOfObjects,'Off')
         %%
         state = 'edit';
         PNGbtnstate(h,state)
         %%
         waitfor(vb.picture_level.picture.imrect)
         %%
         state = 'hold';
         PNGbtnstate(h,state)
         %%
         delete(vb.picture_level.picture.Image)
         h.png_edit = false;
        % refrescamos la figure


end

