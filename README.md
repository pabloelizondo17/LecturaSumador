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

Finalmente se encuentra el subsistema que procesa los datos del resultado de la suma y lo prepara para poderse mostrar en 4 displays de 7 segmentos. Se necesita de al menos 4 displays de 7 segmentos pues el máximo resultado de la suma que se puede obtener, es un número decimal de 4 cifras que corresponde al número 1998. 

Este proceso de poder mostar el resultado de la suma en los displays conlleva varios pasos. Primero se debe de recibir el resultado de la suma y separar sus dígitos en unidades, decenas, centenas y miles (según sea necesario), esto debido a que hay un display para cada posición mencionada. Luego hay un "flip-flop" que sirve como contador para actualizar el display encendido y el código que se le va a enviar a dicho display, esto se hace porque como se trabaja con 4 displays entonces se pueden multiplexar para así ahorrar espacio y componentes electrónicos, de forma que solo estará un único display encendido a la vez, pero como cambian tan rápido el ojo humano no es capaz de darse cuenta de estos cambios entre cada display. 

El contador va cambiando de display conforme se actualiza, con lo cual luego es necesario hacer el siguiente paso, que es definir cuál de los 4 displays está encendido y en base a eso determinar si el código que se le enviará será para el dígito de las unidades, de las decenas, centenas o miles. Según se muestra.

![image](https://github.com/user-attachments/assets/a78a0da6-47ef-4e3c-89ef-63f65a7d7298)

Una vez que ya estén definidos los dos aspectos anteriores, solo resta codificar el dígito que se va ha mostrar en el código para el display de 7 segmentos, según se muestra a continuación.

![image](https://github.com/user-attachments/assets/316fd4d1-1a5f-4858-89f7-f03f2831d194)

Finalmente, el subsistema lanza como salida la variable segments que contiene el código adecuado para mostar en los displays el dígito que corresponda para cada instante de tiempo y el proceso se vuelve a repetir para cada uno de los dígitos de la suma. Así, el resultado final será poder observar los cuatro displays encendidos al mismo tiempo desplegando el resultado de la suma de los valores ingresados por medio del deep switch. 






