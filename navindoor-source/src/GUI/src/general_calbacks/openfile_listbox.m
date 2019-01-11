function openfile_listbox(object,event,h)
%OPENFILE_LISTBOX Summary of this function goes here
%   Detailed explanation goes here
persistent chk
if isempty(chk)
      chk = 1;
      pause(0.5); %Add a delay to distinguish single click from a double click
      if chk == 1
          chk = [];
      end
else
      chk = [];
      open(object.String{object.Value})
end

