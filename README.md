# LecturaSumador
### Segundo proyecto del curso de Diseño Lógico  
Karina Quiros Avila  
Eduardo Tencio Solano  
Pablo Elizondo Espinoza  

## Resumen introductorio
Como parte importante en la ingeniería electrónica, se tienen los lenguajes de descripción de hardware, que permiten tener programas asistidos por computadora y sistemas lógicos que resuelvan tareas complejas de manera eficiente. Este proyecto pretende desarrollar una aplicación en esta área, haciendo uso de una FPGA, algunos componentes electrónicos y el diseño de un circuito, el cual reciba valores numéricos, los sume y finalmente sea capaz de desplegar el resultado en un conjunto de cuatro displays de 7 segmentos.

## Descripción general
En un inicio, el proyecto pretendía desarrollar un modelo de hardware que fuera capaz de leer datos desde un teclado hexadecimal, los procesara y los recolectara para hacer los cálculos necesarios (sumar los valores ingresados); sin embargo, debido a ciertas complicaciones con el desarrollo de esta parte del proyecto, se abrió la posibilidad de trabajar con un deep switch que hiciera llegar los datos.
Partiendo de la modificación anterior, el objetivo es sumar dos números de tres dígitos decimales cada uno; así las cosas, mediante el deep switch es posible ingresar tanto las unidades, decenas y centenas para cada uno de los números requeridos, seperando el proceso por medio de dos botones que habilitan las señales necesarias para indicar el estado actual del procedimiento (pudiéndose representar como una máquina de estados finitos).  
Ahora bien, el primer subsistema consiste en el módulo de lectura y procesamiento para los datos ingresados por medio del deep switch, luego está la lógica del módulo sumador que se encarga de recibir los dos números ya formados y entregar el resultado de su suma; finalmente, para poder ver físicamente el resultado de la suma, está el subsistema de despliegue en los displays de 7 segmentos.  
Todo lo anterior, tiene como principales objetivos el poder comprender el proceso de sincronizar datos que son asincrónicos en un inicio, implementar un procedimiento de captura de datos (por medio del switch para este caso), aplicar un algoritmo de suma sencillo, así como lograr el despliegue en los displays de 7 segmentos y colaborar en equipo para lograr desarrollar el proyecto lo mejor posible. 


## Descripción del funcionamiento general y de sus subsistemas
Como ya se mencionó en los apartados anteriores, el proyecto cuenta con varios submódulos que cumplen funciones diferentes y específicas. Desde la recepción y el procesamiento de señales, hasta los cálculos aritméticos y el despliegue de los datos. Se muestra a continuación una descripción del funcionamiento de cada uno de estos.

### Módulo principal (Top)
Este es el módulo que conecta todos los demás, recibe las señales, las analiza y las asigna a cada uno de los otros submódulos.
El módulo se instancia con las siguientes señales:

![image](https://github.com/user-attachments/assets/b0fdab35-c0df-461b-b482-8ffd5a50e574)

Y se conecta por ejemplo de la siguiente manera, con el módulo que maneja la entrada de señales provenientes del switch:

![image](https://github.com/user-attachments/assets/341e491c-cf36-4708-bb38-5a7c50ab0cd8)


### Subsistema de lectura y procesamiento de datos




### Subsistema de suma aritmética 

### Subsistema de procesamiento de datos y despliegue en displays de 7 segmentos
