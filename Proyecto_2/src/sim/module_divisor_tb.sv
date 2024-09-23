// Testbench del module_divisor.

// Declaracion de la unidad de tiempo.
`timescale 1ns/1ps

module module_divisor_tb;

    // Declaracion de las señales para el testbench.
    logic clk;
    logic rst;
    logic [15:0] numero_input;
    logic [3:0] unidades_output;
    logic [3:0] decenas_output;
    logic [3:0] centenas_output;
    logic [3:0] milesimas_output;

    // Declaracion de las instancias para el testbench, unidad bajo prueba "uut".
    module_divisor uut (

        .clk(clk),
        .rst(rst),
        .numero_input(numero_input),
        .unidades_output(unidades_output),
        .decenas_output(decenas_output),
        .centenas_output(centenas_output),
        .milesimas_output(milesimas_output)

    );

    // Establecer el sistema del reloj, cada periodo es igual a 10 unidades de tiempo.
    always begin

        clk = 1; 
        #5;
        clk = 0;
        #5;

    end

    // Inicio de la prueba del modulo.
    initial begin

        // Valores iniciales de la prueba.
        rst = 1;
        numero_input = 16'd0;

        // Cambio en el valor de rst, tras 10 unidades de tiempo.
        #10;
        rst = 0;

        // Cambio en los valores de entrada, cada 10 unidades de tiempo.
        // Primer cambio, valor introducido 1111101111 (1007).
        #10;
        numero_input = 16'b1111101111;

        // Segundo cambio, valor introducido 5004 (1001110001100).
        #10;
        numero_input = 16'd5004;

        // Tercer cambio, valor introducido 1000011111010 (4346).
        #10;
        numero_input = 16'b1000011111010;

        // Cuarto cambio, valor introducido 1208 (10010111000).
        #10;
        numero_input = 16'd1208;

        // Finalizacion de la prueba.
        #1000;
        $finish;

    end

    // Sistema de guardado de los resultados del testbench.
    initial begin

        $dumpfile("module_divisor_tb.vcd");
        $dumpvars(0,module_divisor_tb);

    end 

endmodule 