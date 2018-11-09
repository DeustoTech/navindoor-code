function velocity_models(panel_parameter_model,popmenu_model)
%VELOCITY_MODELS Summary of this function goes here
%   Detailed explanation goes here

                                          
       %% Damped harmonic oscillator Model
       
       % Agregamos el elemento Damped harmonic oscillator
       len = length(popmenu_model.String);
       popmenu_model.String{len + 1} = 'Damped harmonic oscillator';
        
       % Diseñamos el panel de cofiguracion 

        
               mu_text     = uicontrol('style','text','Parent',panel_parameter_model,'Units','normalized','Position',[0.025 0.075 0.05 0.5],'String','mu');
               mu_edit     = uicontrol('style','edit','Parent',panel_parameter_model,'Units','normalized','Position',[0.075' 0.15 0.05 0.4],'Tag','mu','String','5.0');

               sigma_text  = uicontrol('style','text','Parent',panel_parameter_model,'Units','normalized','Position',[0.175 0.075 0.05 0.5],'String','sigma');
               sigma_edit  = uicontrol('style','edit','Parent',panel_parameter_model,'Units','normalized','Position',[0.225 0.15 0.05 0.4],'Tag','sigma','String','1.0');               
 
               k_text      = uicontrol('style','text','Parent',panel_parameter_model,'Units','normalized','Position',[0.35 0.075 0.05 0.5],'String','k');
               k_edit      = uicontrol('style','edit','Parent',panel_parameter_model,'Units','normalized','Position',[0.400 0.15 0.05 0.4],'Tag','k','String','1.0');    

               lambda_text = uicontrol('style','text','Parent',panel_parameter_model,'Units','normalized','Position',[0.525 0.075 0.07 0.5],'String','lambda');
               lambda_edit = uicontrol('style','edit','Parent',panel_parameter_model,'Units','normalized','Position',[0.6 0.15 0.05 0.4],'Tag','lambda','String','1.0');    

               sections_text = uicontrol('style','text','Parent',panel_parameter_model,'Units','normalized','Position',[0.7 0.075 0.075 0.5],'String','sections');
               sections_edit = uicontrol('style','edit','Parent',panel_parameter_model,'Units','normalized','Position',[0.775 0.15 0.05 0.4],'Tag','sections','String','4');   
               
               % Ayuda 
               CreateStruct.Interpreter = 'latex';
               CreateStruct.WindowStyle = 'modal';
               
               title = 'Damped harmonic oscilator model';
      %         body = { 'La velocidad de cada tramo de la supertraj se genera, a partir de un modelo de un oscilador armónico amortiguado sometido a una fuerza externa. La fuerza externa varia en el tiempo en número de veces determinado por el parámetro sections', ...
      %                  '$\frac{d^2v}{dt^2} = -kv + \lambda \frac{dv}{dt} + N( \mu , \sigma )$'};
               body = '$\frac{d^2v}{dt^2} = -kv + \lambda \frac{dv}{dt} + N( \mu , \sigma )$';
               msg.title = title;
               msg.body  = body; 
                   
               btn_help = help_btn('Parent',panel_parameter_model,'Position',[0.9 0.1 0.04 0.5],'msg',msg,'CreateStruct',CreateStruct);
               
               
   %% Other
   %  ....
end

