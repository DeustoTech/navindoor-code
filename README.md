<<<<<<< HEAD

# NAVINDOOR (MATLAB framework to develop indoor positioning algorithms )

![Navindoor](https://raw.githubusercontent.com/DeustoTech/navindoor-code/master/imgs/logo.png?token=Anpj7OmcvaevOIxXCQsm2G39vtNZ1ACZks5bZDnewA%3D%3D)

### Getting Started 

Se puede iniciar la interfaz gráfica, con el siguiente comando:

```matlab
>> iurgui

```
![iur](https://raw.githubusercontent.com/DeustoTech/navindoor-code/master/imgs/iur-open.gif?token=Anpj7I-oIuUjquVktqbeKgTIJlRBinYWks5bZDoIwA%3D%3D)

### Framework Introduction
Es un framework para MATLAB, dedicado al desarrollo de algoritmos para el posicionamiento en interiores. Este software contiene funcionalidad 
via linea de comandos, además de una interfaz gráfica. 

 Esta subdividido en 5 bloques:
- Planimetry_________________: Genereación de la planimetría de un edificio. Creacions de paredes, puertas, puntos de acceso wifi, 
                                escaleras, ascensores, entre otros. La interfaz gráfica permite la creacion de una clase MATLAB, que contiene
                                toda esta información.
- Trajectories Simulation ___: Representacion de trajectorias en el espacio y en el tiempo mediantes una clase MATLAB. Se puede crear la trajectorias
                                via interfaz grófica, como una suceción de puntos 
- Signal Simulation _________: Representación de seóales de dos tipo: una basadas en puntos de acceso (Beacon Based) y otros independientes de los puntos
                                de acceso (Beacon Free).
- Signal Processing _________: Structura que permite que el procesamiento de las seóales se reduzca a la estimación de la posición en un determinado 
                                instante de la trajectorias. Esto reduce el codigo necesario para desarrollar algoritmos. De esta forma, el usuario 
                                puede centrarse en el desarrollo del algoritmo de estimación. Dentro del propio Framework existen implementaciones de 
                                algoritmos de estimación, con los que se puede aprender a crear nuevos
- Methods Comparison Tools __: Funciones que nos facilitan la comparación de mótodos propios con mótodos ya implementados en el framework. 

La documentacion del proyecto se encuentra alojada en: [visit documentation]("https://navindoor-doc.herokuapp.com/")


### Folder Description:
- *data*: Archivos .mat donde se encuentra algunos ejemplos de las clases mós representativas del framework. 
- *examples*: Scripts donde es explica que se puede hacer con el framework, aunque contiene mucha información sobre 
  la estructuras de las clases, no es un manual por asó decirlo. 
- *helps*: Contiene la información de cada uno de las funciones y clases del framework. Se puede considerar un
  manual de las distintas funciones. Tiene una estructura ya definida.
- *src*: Código fuente de todo el framework
- *test*: Pruebas unitarias para comprobar que el framework funciona correctamente en el equipo donde se ejucutaró.
- *user-folder*: Carpeta vacóa destinada para que el usuario creer sus propios scripts.

### MATLAB Dependences:
Para que el framework funcione, se deberó instalar los siguientes toolbox 
    - Communications System Toolbox 
    - Smooth 
=======

# NAVINDOOR (MATLAB framework to develop indoor positioning algorithms )

![Navindoor](https://raw.githubusercontent.com/DeustoTech/navindoor-code/master/imgs/logo.png?token=Anpj7OmcvaevOIxXCQsm2G39vtNZ1ACZks5bZDnewA%3D%3D)

### Getting Started 

Se puede iniciar la interfaz grÃ¡fica, con el siguiente comando:

```matlab
>> iurgui

```
![iur](https://raw.githubusercontent.com/DeustoTech/navindoor-code/master/imgs/iur-open.gif?token=Anpj7I-oIuUjquVktqbeKgTIJlRBinYWks5bZDoIwA%3D%3D)

### Framework Introduction
Es un framework para MATLAB, dedicado al desarrollo de algoritmos para el posicionamiento en interiores. Este software contiene funcionalidad 
via linea de comandos, ademÃ¡s de una interfaz grÃ¡fica. 

 Esta subdividido en 5 bloques:
- Planimetry_________________: GenereaciÃ³n de la planimetrÃ­a de un edificio. Creacions de paredes, puertas, puntos de acceso wifi, 
                                escaleras, ascensores, entre otros. La interfaz grÃ¡fica permite la creacion de una clase MATLAB, que contiene
                                toda esta informaciÃ³n.
- Trajectories Simulation ___: Representacion de trajectorias en el espacio y en el tiempo mediantes una clase MATLAB. Se puede crear la trajectorias
                                via interfaz grÃ³fica, como una suceciÃ³n de puntos 
- Signal Simulation _________: RepresentaciÃ³n de seÃ³ales de dos tipo: una basadas en puntos de acceso (Beacon Based) y otros independientes de los puntos
                                de acceso (Beacon Free).
- Signal Processing _________: Structura que permite que el procesamiento de las seÃ³ales se reduzca a la estimaciÃ³n de la posiciÃ³n en un determinado 
                                instante de la trajectorias. Esto reduce el codigo necesario para desarrollar algoritmos. De esta forma, el usuario 
                                puede centrarse en el desarrollo del algoritmo de estimaciÃ³n. Dentro del propio Framework existen implementaciones de 
                                algoritmos de estimaciÃ³n, con los que se puede aprender a crear nuevos
- Methods Comparison Tools __: Funciones que nos facilitan la comparaciÃ³n de mÃ³todos propios con mÃ³todos ya implementados en el framework. 

La documentacion del proyecto se encuentra alojada en: [visit documentation]("https://navindoor-doc.herokuapp.com/")


### Folder Description:
- *data*: Archivos .mat donde se encuentra algunos ejemplos de las clases mÃ³s representativas del framework. 
- *examples*: Scripts donde es explica que se puede hacer con el framework, aunque contiene mucha informaciÃ³n sobre 
  la estructuras de las clases, no es un manual por asÃ³ decirlo. 
- *helps*: Contiene la informaciÃ³n de cada uno de las funciones y clases del framework. Se puede considerar un
  manual de las distintas funciones. Tiene una estructura ya definida.
- *src*: CÃ³digo fuente de todo el framework
- *test*: Pruebas unitarias para comprobar que el framework funciona correctamente en el equipo donde se ejucutarÃ³.
- *user-folder*: Carpeta vacÃ³a destinada para que el usuario creer sus propios scripts.

### MATLAB Dependences:
Para que el framework funcione, se deberÃ³ instalar los siguientes toolbox 
    - Communications System Toolbox 
    - Smooth 
>>>>>>> master
