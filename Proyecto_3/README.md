# Multilicador y despliegue en 7 segmentos con teclado hexadecimal

## 1. Abreviaturas y definiciones
- **FPGA**: Field Programmable Gate Arrays
- **FSM**: Máquina de estados finitos

## 2. Resumen
En el presente documento, se explica la implementación de un diseño digital en una FPGA, con el cual, se pretende elaborar un circuito multilicador de números binarios. Se utilizan 3 subsistemas: un subsistema de lectura y registro de dos números decimales de 2 dígitos ingresados mediante un teclado hexadecimal, que se ingresan en forma binaria; un subsistema de despliegue del resultado de la suma en display de 7 segmentos y un subsistema encargado de multiplicar los dos números ingresados.

## 3. Introducción
El presente documento, tiene como objetivo mostrar la elaboración de un multiplicador de números binarios, implementando un diseño digital en una FPGA. Para lograr lo anterior, se elaboró un subsistema de lectura y registro de los números ingresados, el cual, guarda cada dígito de cada número, ingresado en formato binario, para luego ser enviado al subsistema encargado de multiplicar los dos números. Posteriormente, el resultado de la multiplicación se despliega en el display de 7 segmentos.

También, para cada subsistema se elaboraron Testbench, para verificar el adecuado funcionamiento de cada módulo, antes de ser implementado en la FPGA. Finalmente se realizó la implementación en la FPGA, utilizando una protoboard, para lo cual, se usó como referencia el circuito mostrado en la siguiente imagen.
<img doc="Images/ensamblaje.jpg" alt="Ensamblaje en protoboard" width="450" />

### 3.0 Descripción general del sistema

### 3.1 Módulo 1
#### 1. Encabezado del módulo
```SystemVerilog
module mi_modulo(
    input logic     entrada_i,      
    output logic    salida_i 
    );
```
#### 2. Parámetros
- Lista de parámetros

#### 3. Entradas y salidas:
- `entrada_i`: descripción de la entrada
- `salida_o`: descripción de la salida

#### 4. Criterios de diseño
Diagramas, texto explicativo...

#### 5. Testbench
Descripción y resultados de las pruebas hechas

### Otros modulos
- agregar informacion siguiendo el ejemplo anterior.

### 3.X Módulo de prioridad
#### 1. Encabezado del módulo

```SystemVerilog
module module_prio (
    input logic clk,
    input logic rst,
    input logic [7:0] num_1,
    input logic [7:0] num_2,
    input logic listo_1,
    input logic listo_2,
    input logic listo,
    input logic [15:0] num_mul,
    output logic [15:0] numero_output
    );
```

#### 2. Parámetros

- `prioridad`
- `prio_num_1`
- `prio_num_2`
- `prio_num_mul`

#### 3. Entradas y salidas:

- `clk`: Señal del reloj que permite la actualización de los datos de entrada y salida.
- `rst`: Señal procedente del botón de reset que restablece los valores de entrada y salida a 0.
- `num_1`: Valor de entrada binario de 8 bits, este valor proviene del módulo del teclado y representa al primer número de la operación que se realiza.
- `num_2`: Valor de entrada binario de 8 bits, este valor proviene del módulo del teclado y representa al segundo numero de la operación que se realiza.
- `listo_1`: Valor de entrada binario, este valor proviene del módulo del teclado y indica cuando se a digitado completamente el primer número de la operación.
- `listo`: Valor de entrada binario, este valor proviene del módulo del teclado y indica cuando se a digitado completamente el segundo numero de la operación.
- `num_mul`: Valor de entrada binario de 16 bits, este valor proviene del módulo de la operación realizada. 
- `numero_output`: Valor de salida binario de 16 bits, este valor representa el valor que pasaría el módulo BCD para posteriormente mostrarse en los 7 segmentos.

#### 4. Criterios de diseño

Este módulo tiene como objetivo el poder determinar qué valor se estaría presentando en los 7 segmentos en base al orden establecido. Para esto se hace uso de dos señales (`listo_1` y `listo`) provenientes del módulo del teclado. En caso de que se active el `rst` se establece la prioridad por defecto.

<img doc="doc/FSM_modulo_prioridad.png" alt="Maquina de estado de prioridad" width="450" />

```SystemVerilog
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        prioridad <= prio_num_1;
    end else begin
        if (listo) begin
            prioridad <= prio_num_mul;
        end else begin
            if (listo_1) begin
                prioridad <= prio_num_2; 
            end else begin
                    prioridad <= prio_num_1;
            end
        end
    end
end
```

En base a la prioridad asignada se establece el valor a la salida `numero_output` que se conecta con el módulo BCD cada vez que la prioridad cambie.

```SystemVerilog
always_comb begin
    case (prioridad)
        prio_num_1:begin
            numero_output = num_1;
        end 
        prio_num_2:begin
            numero_output = num_2;
        end
        prio_num_mul:begin
            numero_output = num_mul;
        end
        default: begin
            numero_output = 16'd0;
        end
    endcase
end
```

#### 5. Testbench

Para verificar el adecuado funcionamiento del módulo, se realizó un testbench. Primero se definieron las señales de entrada, que se van a generar para probar el módulo, así como las señales de salida.

```SystemVerilog
logic clk;
logic rst;
logic [7:0] num_1;
logic [7:0] num_2;
logic listo_1;
logic listo;
logic [15:0] num_mul;
logic [15:0] numero_output;
```

Posteriormente, se realiza la instanciación del módulo, mediante el cual, se van a conectar las entradas y salidas del módulo con las señales del testbench.

```SystemVerilog
module_prio uut (
    .clk(clk),
    .rst(rst),
    .num_1(num_1),
    .num_2(num_2),
    .listo_1(listo_1),
    .listo(listo),
    .num_mul(num_mul),
    .numero_output(numero_output)
);
```

Luego, se define el funcionamiento del reloj, con 10 unidades de tiempo para cada período y un retraso de 5 unidades de tiempo entre el flanco positivo y el negativo del reloj:

```SystemVerilog
    always begin
        clk = 1; 
        #5;
        clk = 0;
        #5;
    end
```

Luego, se establecen los casos de entrada que se van a tener, estos casos simulan las señales de salida del módulo divisor los cuales van cambiando cada 10 unidades de tiempo.

```SystemVerilog
initial begin
    rst = 1;
    #10;
    rst = 0;
    #10;
    num_1 = 16'd15;
    num_2 = 16'd10;
    num_mul = 16'd150;
    #10;
    listo_1 = 1;
    #10;
    listo = 1;
    #100;
    $finish;
    
end
```

Finalmente, se definen los archivos que van a contener la información de las simulaciones.

```SystemVerilog
initial begin
    $dumpfile("module_prio_tb.vcd");
    $dumpvars(0,module_prio_tb);
end 
```

### 3.X Módulo BCD
#### 1. Encabezado del módulo

```SystemVerilog
module module_BCD(
    input logic clk,
    input logic rst,
    input [15:0] numero_input,
    output logic [3:0] unidades_output,
    output logic [3:0] decenas_output,
    output logic [3:0] centenas_output,
    output logic [3:0] millares_output,
    output logic listo
    );
```

#### 2. Parámetros

- `temp`
- `estado`
- `IDLE`
- `MILLARES`
- `CENTENAS`
- `DECENAS`
- `UNIDADES` 

#### 3. Entradas y salidas:

- `clk`: Señal del reloj que permite la actualización de los datos de entrada y salida.
- `rst`: Señal procedente del botón de reset que restablece los valores de entrada y salida a 0.
- `numero_input`: Valor de entrada binario de 16 bits, proveniente del módulo de prioridad.
- `unidades_output`: Valor de salida binario de 4 bits, esta salida representa las unidades en decimal del número que entro en el subsistema.
- `decenas_output`: Valor de salida binario de 4 bits, esta salida representa las decenas en decimal del número que entro en el subsistema.
- `centenas_output`: Valor de salida binario de 4 bits, esta salida representa las centenas en decimal del número que entro en el subsistema.
- `millares_output`: Valor de salida binario de 4 bits, esta salida representa los millares en decimal del número que entro en el subsistema.
- `listo`: Señal de salida que indica que el ciclo de obtención de resultados ha sido completado y da la indicación del próximo módulo de tomar los datos.

#### 4. Criterios de diseño

Este módulo tiene como objetivo el poder obtener por individualmente las unidades, decenas, centenas y millares; provenientes de un numero en binario.
Para el desarrollo de esta modulo se planteó una máquina de estados finitos o también conocidos como FSM. A continuación, se muestra el diagrama de la máquina de estados:

<img doc="Images/FSM_modulo_BCD.png" alt="Maquina de estado del BCD" width="450" />

El estado `IDLE` tiene la función de asignar el `numero_input` a `temp` para así poder manipular esta variable de forma interna sin afectar o modificar la entrada. Además de restablecer los valores de salida a cero. Con ello se procede al siguiente estado siendo en este caso `MILLARES`.

El estado `MILLARES` tiene la función de obtener los millares del número `temp` para ello se estableció que si el `temp` es mayor o igual a mil, con ello a `millares_output` se le agregaría uno y a `temp` se le restarían mil; así hasta que `temp` sea menor a mil y se pase al siguiente estado siendo en este caso `CENTENAS`. A continuación, se muestra el código aplicado para cumplir esta condición:

```SystemVerilog
MILLARES: begin
    if (temp >= 1000) begin
        millares_output <= millares_output + 1;
        temp <= temp - 1000;
    end else begin
        estado <= CENTENAS;
    end
end
```

La misma lógica del estado `MILLARES` se aplica a los estados `CENTENAS` y `DECENAS`. Para el estado `UNIDADES` es un poco distinto debido a que el numero `temp` que ha sobrado de las operaciones anteriores en los estados anteriores seria nuestro `unidades_output` y la señal `listo` se activaría dando por completado el ciclo de esta máquina de estados para ello volver al estado inicial `IDLE`. A continuación, se muestra el código aplicado para cumplir esta condición:

```SystemVerilog
UNIDADES: begin
    unidades_output <= temp;
    estado <= IDLE;
    listo <= 1'b1;
end
```

#### 5. Testbench

Para verificar el adecuado funcionamiento del módulo, se realizó un testbench. Primero se definieron las señales de entrada, que se van a generar para probar el módulo, así como las señales de salida.

```SystemVerilog
logic [15:0] numero_input;
logic clk;
logic rst;
logic [3:0] unidades_output;
logic [3:0] decenas_output;
logic [3:0] centenas_output;
logic [3:0] millares_output;
logic listo;
```

Posteriormente, se realiza la instanciación del módulo, mediante el cual, se van a conectar las entradas y salidas del módulo con las señales del testbench:

```SystemVerilog
module_BCD uut (
    .numero_input(numero_input),
    .clk(clk),
    .rst(rst),
    .unidades_output(unidades_output),
    .decenas_output(decenas_output),
    .centenas_output(centenas_output),
    .millares_output(millares_output),
    .listo(listo)
);
```

Luego, se define el funcionamiento del reloj, con 10 unidades de tiempo para cada período y un retraso de 5 unidades de tiempo entre el flanco positivo y el negativo del reloj:

```SystemVerilog
always begin
    clk = 1; 
    #5;
    clk = 0;
    #5;
end
```

Con ello se inició la prueba planteando distintos casos, para observar los resultados se establece por medio del comando $display el cual permite verlos en el terminal; a continuación, se puede observar el código implementado.

```SystemVerilog
initial begin
    rst = 1;
    numero_input = 0;
    #10; 
    rst = 0; 
    #10; numero_input = 16'd1234;
    #10; wait(listo);
    #10;
    $display("Numero: %d, Millares: %d, Centenas: %d, Decenas: %d, Unidades: %d", numero_input, millares_output, centenas_output, decenas_output, unidades_output);
    #10; numero_input = 16'd5678;
    #10; wait(listo);
    #10; 
    $display("Numero: %d, Millares: %d, Centenas: %d, Decenas: %d, Unidades: %d", numero_input, millares_output, centenas_output, decenas_output, unidades_output);
    #10; numero_input = 16'd910; 
    #10; wait(listo);
    #10; 
    $display("Numero: %d, Millares: %d, Centenas: %d, Decenas: %d, Unidades: %d", numero_input, millares_output, centenas_output, decenas_output, unidades_output);
    #10; wait(listo);
    #10; 
    $display("Numero: %d, Millares: %d, Centenas: %d, Decenas: %d, Unidades: %d", numero_input, millares_output, centenas_output, decenas_output, unidades_output);
    #10;
    $finish;
end
```

### 3.X Módulo de despliegue en los 7 segmentos
#### 1. Encabezado del módulo

```SystemVerilog
module module_seg (
    input logic clk,
    input logic rst,
    input logic [3:0] unidades_input,
    input logic [3:0] decenas_input,
    input logic [3:0] centenas_input,
    input logic [3:0] millares_input,
    input logic listo,
    output logic [6:0] seg,
    output logic [3:0] transis
    );
```

#### 2. Parámetros

- `unidades`
- `decenas`
- `centenas`
- `millares`
- `numero`
- `selec`
- `UNI`
- `DEC`
- `CEN`
- `MIL`

#### 3. Entradas y salidas:

- `clk`: Señal del reloj que permite la actualización de los datos de entrada y salida.
- `rst`: Señal procedente del botón de reset que restablece los valores de entrada y salida a 0.
- `unidades_input`:  Valor de entrada en binario de 4 bits, esta entrada representa las unidades que van del 0 al 9.
- `decenas_input`: Valor de entrada en binario de 4 bits, esta entrada representa las decenas que van del 0 al 9.
- `centenas_input`: Valor de entrada en binario de 4 bits, esta entrada representa las centenas que van del 0 al 9.
- `milesimas_input`: Valor de entrada en binario de 4 bits, esta entrada representa los millares que van del 0 al 9.
- `listo`: Señal de entrada que indica cuando los valores de entrada de unidades, decenas, centenas y millares está listo para enseñarse en los 7 segmentos.
- `seg`: Es el conjunto de valores de salida que se conectan de los pines de la FPGA a los 7 segmentos.
- `transis`: Es el conjunto de valores de salida que se conectan de los pines de la FPGA a los transistores que activan o desactivan los 7 segmentos.

#### 4. Criterios de diseño
Este módulo tiene como objetivo el mostrar en decimales las unidades, decenas, centenas y millares; en los dispositivos 7 segmentos los cuales se encuentran conectados con distintos pines de la FPGA.
Para el desarrollo de este módulo se planteó que las entradas de los 7 segmentos estuvieran conectadas en paralelo, los cuales alternan su activación por medio de los transistores y de esta forma se mostrara los valores de unidades, decenas, centenas y millares. El módulo se encuentra estructura de la siguiente forma:

Se asignan los datos de entrada provenientes del módulo BCD a las variables internas únicamente se da cuando la señal de `listo` del BCD este activada para que lo presentado en los 7 segmentos se un numero completo correctamente decodificado; de igual forma en esta sección se restablece los valores internos cuando se activa el `rst`.

```SystemVerilog
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        unidades <= 4'd0;
        decenas <= 4'd0;
        centenas <= 4'd0;
        millares <= 4'd0;
    end 
end
```

```SystemVerilog
always_comb begin
    if (listo) begin
        unidades = unidades_input;
        decenas = decenas_input;
        centenas = centenas_input;
        millares = millares_input;
    end
end
```

Se establece una máquina de estados la cual cambia de estado en cada flanco de reloj, como se muestra a continuación.

<img doc="Images/FSM_modulo_7_segmentos.png" alt="Maquina de estado de los 7 segmentos" width="450" />

```SystemVerilog
always_ff @(posedge clk) begin
    if (rst) begin
        selec <= 2'd0;
    end else begin
        selec <= (selec + 1) % 4;
    end
end
```

En esta máquina de estados se establece cuál de los valores internos (`unidades`, `decenas`, `centenas`, `millares`) se está proyectando en los 7 segmentos a su vez se activan y desactivan los transistores de cada uno de estos.

```SystemVerilog
always_comb begin 
    case (selec)
        UNI:begin
            numero = unidades;
            transis = 4'b0001;
        end
        DEC:begin
            numero = decenas;
            transis = 4'b0010;
        end
        CEN:begin
            numero = centenas;
            transis = 4'b0100;
        end
        MIL:begin
            numero = millares;
            transis = 4'b1000;
        end
        default: begin
            numero = 4'd0;
            transis = 4'b0000;
        end
    endcase
end
```

Para los valores presentados `numero` se plantea con lógica combinacional para así que cada vez que este valor cambie se actualice el dato de salida a los 7 segmentos, esta salida `seg` se daría en un conjunto de 7 bits que representan los segmentos a, b, c, d, e, f y g; esto se puede observar como el siguiente formato `7'babcdefg`.

```SystemVerilog
always_comb begin
    case (numero)
        4'd0: seg = 7'b0000001;
        4'd1: seg = 7'b1001111;
        4'd2: seg = 7'b0010010;
        4'd3: seg = 7'b0000110;
        4'd4: seg = 7'b1001100;
        4'd5: seg = 7'b0100100;
        4'd6: seg = 7'b0100000;
        4'd7: seg = 7'b0001111;
        4'd8: seg = 7'b0000000;
        4'd9: seg = 7'b0000100;
        default: seg = 7'b0110110;
    endcase
end
```

#### 5. Testbench

Para verificar el adecuado funcionamiento del módulo, se realizó un testbench. Primero se definieron las señales de entrada, que se van a generar para probar el módulo, así como las señales de salida.

```SystemVerilog
logic clk;
logic rst;
logic [3:0] unidades_input;
logic [3:0] decenas_input;
logic [3:0] centenas_input;
logic [3:0] milesimas_input;
logic listo;
logic [6:0] seg;
logic [3:0] transis;
```

Posteriormente, se realiza la instanciación del módulo, mediante el cual, se van a conectar las entradas y salidas del módulo con las señales del testbench.

```SystemVerilog
module_seg uut (
    .clk(clk),
    .rst(rst),
    .unidades_input(unidades_input),
    .decenas_input(decenas_input),
    .centenas_input(centenas_input),
    .millares_input(millares_input),
    .listo(listo),
    .seg(seg),
    .transis(transis)
);
```

Luego, se define el funcionamiento del reloj, con 10 unidades de tiempo para cada período y un retraso de 5 unidades de tiempo entre el flanco positivo y el negativo del reloj:

```SystemVerilog
always begin
    clk = 1; 
    #5;
    clk = 0;
    #5;
end
```

Luego, se establecen los casos de entrada que se van a tener, estos casos simulan las señales de salida del módulo divisor los cuales van cambiando cada 10 unidades de tiempo.

```SystemVerilog
initial begin
    rst = 1;
    unidades_input = 4'd0;
    decenas_input = 4'd0;
    centenas_input = 4'd0;
    millares_input = 4'd0;
    listo = 0;
    #10;
    rst = 0;
    #40;
    unidades_input = 4'd9;
    decenas_input = 4'd0;
    centenas_input = 4'd6;
    millares_input = 4'd7;
    listo = 1;
    #10;
    listo = 0;
    #40;
    unidades_input = 4'd3;
    decenas_input = 4'd9;
    centenas_input = 4'd1;
    millares_input = 4'd3;
    listo = 1;
    #10;
    listo = 0;
    #40;
    unidades_input = 4'd4;
    decenas_input = 4'd9;
    centenas_input = 4'd0;
    millares_input = 4'd0;
    listo = 1;
    #10;
    listo = 0;
    #100;
    $finish;   
end
```

Finalmente, se definen los archivos que van a contener la información de las simulaciones.

```SystemVerilog
initial begin
    $dumpfile("module_seg_tb.vcd");
    $dumpvars(0,module_seg_tb);
end 
```

## 4. Consumo de recursos

## 5. Problemas encontrados durante el proyecto

## 6. Referencias
[0] David Harris y Sarah Harris. *Digital Design and Computer Architecture. RISC-V Edition.* Morgan Kaufmann, 2022. ISBN: 978-0-12-820064-3

