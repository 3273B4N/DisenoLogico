# Circuito decodificador de Gray

## 1. Abreviaturas y definiciones
- **FPGA**: Field Programmable Gate Arrays

## 2. Resumen
En el presente documento, se explica la implementación de un diseño digital en una FPGA, con el cual, se pretende elaborar un decodificador de código Gray. Se utilizan 3 subsistemas: un subsistema de lectura y decodificación de código Gray, un subsistema de despliegue de código ingresado traducido a formato binario en luces LED y un último subsistema que despliega el código decodificado en display de 7 segmentos.

## 3. Introducción
El presente documento, tiene como objetivo mostrar la elaboración de un decodificador de código Gray, implementando un diseño digital en una FPGA. Para lograr lo anterior, se elaboró un subsistema de lectura y decodificación de código Gray, el cual, traduce dicho código a código binario, antes de ser enviado a los otros subsistemas. Además, se hicieron otros dos subsistemas, que muestran el código decodificado en luces Led y display de 7 segmentos, respectivamente.

También, para cada subsistema se elaboraron Testbench, para verificar el adecuado funcionamiento de cada módulo, antes de ser implementado en la FPGA. Finalmente se realizó la implementación en la FPGA, utilizando una protoboard, para lo cual, se usó como referencia el circuito mostrado en la siguiente imagen. 


<img src="Images/ImplementacionFPGA.png" alt="Alambrado en protoboard" width="450" />

Sin embargo, no se utilizaron los transistores PNP 2N3906, debido a que el subsistema de despliegue del código decodificado en los 7-segmentos, no lo requiere. 

## 3. Desarrollo

### 3.0 Descripción general del sistema

El sistema que se requiere elaborar es un decodificador de código Gray, para lo cual, se plantea la realización de tres subsistemas: un subsistema de lectura y decodificación de código Gray y dos subsistemas que despliegan el código decodificado, en leds y display de 7 segmentos, respectivamente.
#### 1. Testbench

### 3.1 Subsistema de lectura y decodificación de código Gray
#### 1. Encabezado del módulo
```SystemVerilog
module decoder (
    input logic ag, bg, cg, dg, 
    output logic ab, bb, cb, db);
```
#### 2. Entradas y salidas:
- `ag, bg, cg, dg`: bits de entrada en código Gray
- `ab, bb, cb, db`: bits de salida en código binario

#### 3. Criterios de diseño
El presente subsistema recibe un código Gray de 4 bits, el cual, se decodifica a código binario, para ser enviado a los otros subsistemas. A continuación se muestra el diagrama de bloques del subsistema:


Una vez que se definen las entradas y salidas mencionadas anteriormente, se utiliza lógica booleana para realizar la decodificación. Para el bit más significativo de código binario, se le asigna el valor igual bit más significativo del código Gray, ya que, el bit más significativo del código binario siempre es igual al bit más significativo del código Gray:
```SystemVerilog
assign ab = ag;
```
Para obtener la salida bb, se utiliza la operación booleana XOR, entre las entradas ab y bg, esto ya que, para obtener cada bit en binario, se puede utilizar la operación booleana XOR, del bit actual Gray con el bit anterior del código Gray. Lo mismo se hace para generar los demás bits del código binario:
```SystemVerilog
    assign bb = (ag ^ bg);
    assign cb = ((ag ^ bg) ^ cg);
    assign db = (((ag ^ bg) ^ cg) ^ dg);
```
#### 4. Testbench
Para verificar el adecuado funcionamiento del módulo, se realizó un testbench. Primero se defnieron las señales de entrada, que se van a generar para probar el módulo, así como las señales de salida:
```SystemVerilog
     // Inputs
    reg ag;
    reg bg;
    reg cg;
    reg dg;

    // Outputs
    wire ab;
    wire bb;
    wire cb;
    wire db;
```
Posteriormente, se realiza la instanciación del módulo, mediante el cual, se van a conectar las entradas y salidas del módulo decoder con las señales del testbench:
```SystemVerilog
     decoder dut (
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .ab(ab),
        .bb(bb),
        .cb(cb),
        .db(db)
    );
```
Luego, se establecen los casos de entrada que se van a tener, estos casos simulan el código Gray que se va a ingresar en el subsistema, además se establece que, para hacer un cambio en las señales se espere un tiempo de 10 nanosegundos:
```SystemVerilog
     
   initial begin
       
        ag = 0; bg = 0; cg = 0; dg = 0;

		#10; ag = 0; bg = 0; cg = 0; dg = 0; 
        #10; ag = 1; bg = 0; cg = 0; dg = 0; 
        #10; ag = 0; bg = 1; cg = 0; dg = 0;
        #10; ag = 1; bg = 1; cg = 0; dg = 0;
        #10; ag = 0; bg = 0; cg = 1; dg = 0; 
        #10; ag = 1; bg = 0; cg = 1; dg = 0; 
        #10; ag = 0; bg = 1; cg = 1; dg = 0; 
        #10; ag = 1; bg = 1; cg = 1; dg = 0; 
        #10; ag = 0; bg = 0; cg = 0; dg = 1; 
        #10; ag = 1; bg = 0; cg = 0; dg = 1; 
        #10; ag = 0; bg = 1; cg = 0; dg = 1;
        #10; ag = 1; bg = 1; cg = 0; dg = 1; 
        #10; ag = 0; bg = 0; cg = 1; dg = 1; 
        #10; ag = 1; bg = 0; cg = 1; dg = 1;
        #10; ag = 0; bg = 1; cg = 1; dg = 1; 
        #10; ag = 1; bg = 1; cg = 1; dg = 1; 
        
        $finish;
    end
```
Finalmente, se definen los archivos que van a contener la información de las simulaciones:
```SystemVerilog
     initial begin
    $dumpfile("decoder_tb.vcd");
    $dumpvars(0,decoder_tb);
    end
```

### 3.2  Subsistema de despliegue de código ingresado traducido a formato binario
en luces LED
#### 1. Encabezado del módulo
```SystemVerilog
module module_leds (
    input logic [3:0] binario,
    output reg[3:0] led
    );
```

#### 2. Entradas y salidas:
- `binario`: entrada de 4 bits, que proviene del subsistema de lectura y decodificación de código Gray.
- `led`: salida de 4 bits, que se encarga de manejar los leds en la FPGA.

#### 3. Criterios de diseño
Diagramas, texto explicativo...

#### 4. Testbench
Descripción y resultados de las pruebas hechas

### 3.3  Subsistema de despliegue de código decodificado en display de 7 segmentos.
#### 1. Encabezado del módulo
```SystemVerilog
module module_seg (
    input logic clk,
    input logic A, B, C, D,
    output logic au, bu, cu, du, eu, fu, gu,0
    output logic ad, bd, cd, dd, ed, fd, gd 
    );
```

#### 2. Entradas y salidas:
- `clk`: reloj que actualiza en los 7 segmentos los valores binarios recibidos.
- `A, B, C, D,`: variables de entrada, que provienen del subsistema de lectura y decodificación de código Gray.
-  `au, bu, cu, du, eu, fu, gu,0`: variables de salida que controlan los pines de la FPGA, que se conectan a cada uno de los segmentos, del 7 segmentos que representa las unidades.
 -  `au, bu, cu, du, eu, fu, gu,0`: variables de salida que controlan los pines de la FPGA, que se conectan a cada uno de los segmentos, del 7 segmentos que representa las decenas.


#### 3. Criterios de diseño
Diagramas, texto explicativo...

#### 4. Testbench
Descripción y resultados de las pruebas hechas


## 4. Consumo de recursos

## 5. Problemas encontrados durante el proyecto

## 6. Referencias
[0] David Harris y Sarah Harris. *Digital Design and Computer Architecture. RISC-V Edition.* Morgan Kaufmann, 2022. ISBN: 978-0-12-820064-3
