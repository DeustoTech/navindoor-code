# Navindoor MATLAB Software 

Navindoor es un framework de matlab desarrollado para el desarrollo de algoritmos de localización en interiores. Este software contiene una interfaz gráfica que permite generar nuevos algoritmos de forma intuitiva
# Features

# Getting Started
Para empezar deberemos agregar las siguientes direcciones 
```matlab
addpath(genpath('WorkFolder'))
addpath(genpath('navindoor-source'))
```
Esto nos permite accedes a todas las funciones dentro de las carpetas `WorkFolder` y `navindoor-source`. A continuación describiremos brevemente estas dos carpetas:
 
- **WorkFolder**: Contiene los algoritmos de localización, los modelos de ruido para generar señales, también contiene los modelos que generan la trajectorias. Esta carpeta contendrá todo nuestro desarrollo
- **navindoor-source**: Contiene la estructura que todos estos modelos seguirán. Es necesario para que todas las modelos sigan un mismo modelo.

Para abrir la interfaz gráfica deberemos escribir el siguiente comando:

```matlab
iur
```
## Crear un planimetría



