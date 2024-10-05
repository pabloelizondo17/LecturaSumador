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

De la misma manera como se conecta con el módulo que procesa la entrada de los datos, el module_Top se conecta con el adder_submodule y el display_multiplexer para hacer los cálculos aritméticos necesarios y desplegar la suma en los displays, su funcionamiento se detalla en los siguientes apartados. 


### Subsistema de lectura y procesamiento de datos
Este submódulo llamado en el archivo como input_manager.sv, es el que va registrando los datos que se van ingresando con el deep switch, utiliza las siguientes variables.

![image](https://github.com/user-attachments/assets/5a905371-b0c0-4ad9-a983-6df795f74c65)

Como el sistema lo que hace es ir recogiendo cada una de las cifras que van a componer el número por separado, se utiliza un "case" dentro de un "flip-flop" de forma que se recolectan las centenas primeramente, luego las decenas y finalmente las unidades, se va actualizando el valor de la variable state para corroborar cuáles dígitos son los que se han ingresado. Finalmente se levanta una bandera para indicar que se ingresaron y registraron correctamente los tres dígitos de uno de los dos números y se procede a formar el número decimal de tres cifras, para luego enviarlo al módulo principal (Top) y que el número sea procesado por el sumador. El mismo proceso se repite para el segundo número y en caso de querer restablecer todo y volver al inicio, se puede presionar el botón de reset. 

### Subsistema de suma aritmética 
Este subsistema es el encargado de recibir y sumar los dos números formados por el subsistema de lectura y procesamiento de datos. Su estructura es relativamente corta, según se muestra a continuación.

![image](https://github.com/user-attachments/assets/27db97cd-fa0a-4003-a08f-6e1cc948d76c)

Este subsistema tiene que corroborar ciertos aspectos antes y después de aplicar la suma. Primero se debe de verificar que los dos números a sumar estén listos y ya hayan sido enviados desde el subsistema de procesamiento de los datos ingresados; una vez verificado esto, dentro de un flip-flop se hace una suma de ambos números en el flanco positivo del reloj siempre que la señal enable esté en alto, seguidamente se activa la señal sum_ready que indica cuando la suma está lista y se produce una salida con el resultado de la suma. 


### Subsistema de procesamiento de datos y despliegue en displays de 7 segmentos
