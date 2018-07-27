function help_event(object,event,msg,varargin)
%HELP_EVENT Summary of this function goes here
%   Detailed explanation goes here
     p = inputParser;
     addOptional(p,'CreateStruct',[])
     parse(p,varargin{:})
     
     CreateStruct = p.Results.CreateStruct;
     
     if ~isempty(CreateStruct)
         msgbox(msg.body,msg.title,CreateStruct)
     else
         msgbox(msg)
     end     
end

