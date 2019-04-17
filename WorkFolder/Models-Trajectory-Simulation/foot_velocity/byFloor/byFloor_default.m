function Events = byFloor_default(isegment,frecuency,varargin)
    % description: La funcion byFloor_default es una funcion convierte un objecto de la clase segment  en Eventos que luego seran utilizados para 
    %               construir el GroundTruth del pie. Se utiliza la funcion externa simula_trayecto, creada para el paper 
    %               Simulation of Foot-Mounted IMU Signals for the Evaluation of PDR Algorithms, de Francisco J. Zampella, Antonio R. Jim�enez, Fernando Seco, J. Carlos Prieto, Jorge I. Guevara.
    %               La simulacion se realiza suuponiendo que la trajectoria del pie se da sobre una trayectoria en una planta.
    % MandatoryInputs:   
    %       isegment: 
    %           description: the Segment is the section of trajectory that will be simulate. This object 
    %                   has a property called type. This property will be equal to Floor. This indicate 
    %                   that the simulation of trajectory is in floor.
    %                   
    %           class: segment
    %           dimension: [1xN]
    %       frecuency: 
    %           description: interval of time of mesurements
    %           class: double
    %           dimension: [1x1]       
    % OptionalInputs:
    %       length_step:
    %           description: Length step of pedertrian
    %           class: double
    %           dimension: [1x1]
    % Outputs:
    %       Events:
    %           description: List of object Events. Event is a MATLAB class that 
    %                        represents the point [x,y,z,t]. The trajectory is define by a list 
    %                        of events.
    %           class: Events
    %           dimension: [1x1]    
    
    
        %%
    p = inputParser;
    
    addRequired(p,'isegment')       % isegment  - Segmento donde se aplicara el modelo de velocidad en un mismo nivel
    addRequired(p,'frecuency')      % frecuency - frecuencia de muestreo
    addOptional(p,'length_step',1)  % length    - Velocidad dentro de la seccion isegment

    
    parse(p,isegment,frecuency,varargin{:})
    
    frecuency   = p.Results.frecuency;
    length_step = p.Results.length_step;
    
    z0 = isegment.points(1).z;
    %% Creamos los points recta , circulos para que se pueda ejecutar simula_trayecto
    points = vec2mat([isegment.points.r],3);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %figure
    %line(points(:,1),points(:,2),'Color','r','Marker','o')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if length(isegment.points) < 3
        i = 1;
        fs = frecuency;
        speed = (length_step/1.3)^3;

        Pos_G_ini = [points(2*i-1,1) points(2*i-1,2) 0];
        direccion = (180/pi)*atan_2pi(points(2*i,:)-points(2*i-1,:));
        curvatura = 0;

        longitud = norm(points(2*i - 1,:) - points(2*i,:));
        [Acc_total,Gyr_total,Mag,Stance_total,StepDectSample,Pos_G_total,Vel_G_total,Att_G_total] = simula_trayecto(longitud,speed,direccion,curvatura,Pos_G_ini,[0 0 45],9.8,fs,0,0);

        num_muestras = length(Pos_G_total);
        Events = zeros(1,num_muestras,'Event');

        for index = 1:num_muestras

            Events(index).x = Pos_G_total(index,1);
            Events(index).y = Pos_G_total(index,2);
            Events(index).z = Pos_G_total(index,3) + z0;

            %
            Events(index).vx = Vel_G_total(index,1);
            Events(index).vy = Vel_G_total(index,2);
            Events(index).vz = Vel_G_total(index,3);
            %
            Events(index).ax = Acc_total(index,1);
            Events(index).ay = Acc_total(index,2);
            Events(index).az = Acc_total(index,3);
            %
            Events(index).gyrox = Gyr_total(index,1);
            Events(index).gyroy = Gyr_total(index,2);
            Events(index).gyroz = Gyr_total(index,3);
            %
            Events(index).attx = Att_G_total(index,1);
            Events(index).atty = Att_G_total(index,2);
            Events(index).attz = Att_G_total(index,3);

            Events(index).stance = Stance_total(index);
        end
        return
    end
    r1 = points(1,1:2);
    r2 = points(2,1:2);
    r3 = points(3,1:2);

    new_points      = [];
    logitud_arcos   = [];
    signo_curvatura = [];
    radios          = [];


    num_points = length(points);
    for indx = 3:num_points
        
        dangle = abs(atan_2pi(r2-r1)- atan_2pi(r2-r3));
        % siempre cogemos el angulo mas peque�o
        if dangle > pi
            dangle = 2*pi - dangle;
        end
        
        if dangle*180/pi > 170||norm(r2-r3)<length_step

            if indx ~= num_points
                r2 = r3;
                r3 = points(indx+1,1:2);
            else
                if isempty(radios)
                    rc2 =  points(1,1:2);
                    r3  =  points(indx,1:2);
                end
            end
            continue
        end
        
        Rmax = 1.25;
        Rmin = 0.5;
        R = (pi - dangle )/(pi)*(Rmin - Rmax) + Rmax;
        radios = [radios R];
        
        sc = (r2(1) - r1(1))*(r3(2) -r1(2)) - (r2(2)-r1(2))*(r3(1)-r1(1)) > 0;
        signo_curvatura(indx-2) = sc;
        %


        %
        
        [~ ,rc1, rc2, ~ ,long_arco] = segmentation(r1,r2,r3,R);
        
        logitud_arcos = [ logitud_arcos long_arco];
        %
        new_points =  [new_points;r1];
        new_points =  [new_points;rc1];
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %line(new_points(:,1),new_points(:,2),'Color','g','Marker','*')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%
        if indx ~= length(points)
            r1 = rc2;
            r2 = r3;
            r3 = points(indx+1,1:2);
        end
    end
    
    indx = indx + 1;
    new_points = [new_points; rc2];
    new_points = [new_points; r3];
        
    
    %%
    speed = (length_step/1.3)^3;

%%
Pos_G_total = [];
Vel_G_total = [];
Acc_total = [];
Gyr_total = [];
Att_G_total = [];
Stance_total = [];
fs = frecuency;
for i = 1:length(logitud_arcos)+1
    Pos_G_ini = [new_points(2*i-1,1) new_points(2*i-1,2) 0];
    direccion = (180/pi)*atan_2pi(new_points(2*i,:)-new_points(2*i-1,:));
    curvatura = 0;

    longitud = norm(new_points(2*i - 1,:) - new_points(2*i,:));
    [Acc,Gyr,Mag,Stance,StepDectSample,Pos_G,Vel_G,Att_G] = simula_trayecto(longitud,speed,direccion,curvatura,Pos_G_ini,[0 0 45],9.8,fs,0,0);
    Pos_G_total = [Pos_G_total;Pos_G];
    Vel_G_total = [Vel_G_total; Vel_G];
    Acc_total = [Acc_total;Acc];
    Gyr_total = [Gyr_total;Gyr];
    Att_G_total = [Att_G_total;Att_G];
    Stance_total = [Stance_total;Stance];

    if i == (length(logitud_arcos)+1)
        break
    end
    Pos_G_ini = [new_points(2*i,1) new_points(2*i,2) 0];
    if signo_curvatura(i)
        sgn = 1;
    else
        sgn = -1;
    end
    curvatura = 1/radios(i)*sgn;
    longitud = logitud_arcos(i);
    if longitud 
        
    end
    [Acc,Gyr,Mag,Stance,StepDectSample,Pos_G,Vel_G,Att_G] = simula_trayecto(longitud,speed,direccion,curvatura,Pos_G_ini,[0 0 45],9.8,fs,0,0);
    %
    Pos_G_total = [Pos_G_total;Pos_G];
    Acc_total = [Acc_total;Acc];
    Gyr_total = [Gyr_total;Gyr];
    Vel_G_total = [Vel_G_total; Vel_G];
    Att_G_total = [Att_G_total;Att_G];
    Stance_total = [Stance_total;Stance];
end

num_muestras = length(Pos_G_total);
Events = Event.empty;
%%





for index = 1:num_muestras
    
    Events(index).x = Pos_G_total(index,1);
    Events(index).y = Pos_G_total(index,2);
    Events(index).z = Pos_G_total(index,3) + z0;

    %
    Events(index).vx = Vel_G_total(index,1);
    Events(index).vy = Vel_G_total(index,2);
    Events(index).vz = Vel_G_total(index,3);
    %
    Events(index).ax = Acc_total(index,1);
    Events(index).ay = Acc_total(index,2);
    Events(index).az = Acc_total(index,3);
    %
    Events(index).gyrox = Gyr_total(index,1);
    Events(index).gyroy = Gyr_total(index,2);
    Events(index).gyroz = Gyr_total(index,3);
    %
    Events(index).attx = Att_G_total(index,1);
    Events(index).atty = Att_G_total(index,2);
    Events(index).attz = Att_G_total(index,3);
    
    Events(index).stance = Stance_total(index);
    
    
end
%%

function [ri ,rc1, rc2, rf ,long] = segmentation(r1,r2,r3,R)
    %%
    m1 = (r2(2) - r1(2))/(r2(1) - r1(1));
    if  m1 == Inf 
        m1 = 1e10;
    elseif m1 == -Inf
        m1 = -1e10;
    end
    n1 = r1(2) - m1*r1(1);
    y1 = @(x) m1*x +n1;

    %%
    m2 = (r3(2) - r2(2))/(r3(1) - r2(1));
    if  m2 == Inf 
        m2 = 1e10;
    elseif m2 == -Inf
        m2 = -1e10;
    
    end
    n2 = r2(2) - m2*r2(1);
    y2 = @(x) m2*x +n2;


    
    %% Calculamos el area donde se encuentra el circulo 
    if y1(r3(1)) < r3(2)
        sign1 = '<';  
    elseif y1(r3(1)) > r3(2)
        sign1 = '>' ;   
    else
        error('Alineadas')
    end

    if y2(r1(1)) < r1(2)
        sign2 = '<';  
    elseif y2(r1(1)) > r1(2)
        
        sign2 = '>' ;   
    else
        error('Alineadas')
    end


    y1plus  = @(x) y1(x) +  R*sqrt(m1^2+1);
    y1minus = @(x) y1(x) -  R*sqrt(m1^2+1);

    y2plus  = @(x) y2(x) +  R*sqrt(m2^2+1);
    y2minus = @(x) y2(x) -  R*sqrt(m2^2+1);


    
    %% Hallamos los 4 

    xc1 = -((n1-n2) + R*(sqrt(m1^2+1) - sqrt(m2^2+1)))/(m1-m2);
    yc1 = y1plus(xc1);

    xc2 = -((n1-n2) + R*(sqrt(m1^2+1) + sqrt(m2^2+1)))/(m1-m2);
    yc2 = y1plus(xc2);

    xc3 = -((n1-n2) - R*(sqrt(m1^2+1) + sqrt(m2^2+1)))/(m1-m2);
    yc3 = y1minus(xc3);

    xc4 = -((n1-n2) + R*(sqrt(m2^2+1) - sqrt(m1^2+1)))/(m1-m2);
    yc4 = y1minus(xc4);


    %%
    if eval(['y1(xc1)' sign1,'yc1',' && ','y2(xc1)' sign2,'yc1'])
        xc = xc1;
        yc = yc1;
    elseif eval(['y1(xc2)' sign1,'yc2',' && ','y2(xc2)' sign2,'yc2'])
        xc = xc2;
        yc = yc2;
    elseif eval(['y1(xc3)' sign1,'yc3',' && ','y2(xc3)' sign2,'yc3'])
        xc = xc3;
        yc = yc3;   
    elseif eval(['y1(xc4)' sign1,'yc4',' && ','y2(xc4)' sign2,'yc4'])
        xc = xc4;
        yc = yc4; 
    end


   %%%line(xc,yc,'Color','y','Marker','p')
    %% 
    xs1 = (-m1*n1 + xc + m1*yc)/(1+m1^2);
    ys1 = y1(xs1);

    xs2 = (-m2*n2 + xc + m2*yc)/(1+m2^2);
    ys2 = y2(xs2);

    %%
    ri = r1;
    rc1 = [xs1 ys1];
    rc2 = [xs2 ys2];
    rf = r3;

    %%
    long = R*acos(dot((rc1 - [xc yc]),(rc2 - [xc yc]))/R^2);

    end

end

