// Testbench del subsistema 3, modulo en uut module_seg.

// Declaracion de la unidad de tiempo.
`timescale 1ns/1ps

module module_seg_tb;

    // Declaracion de las señales para el testbench.
    logic clk;
    logic rst;
    logic [3:0] unidades_input;
    logic [3:0] decenas_input;
    logic [3:0] centenas_input;
    logic [3:0] millares_input;
    logic listo;
    logic [6:0] seg;
    logic [3:0] transis;

    // Declaracion de las instancias para el testbench, unidad bajo prueba "uut".
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
        unidades_input = 4'd0;
        decenas_input = 4'd0;
        centenas_input = 4'd0;
        millares_input = 4'd0;
        listo = 0;

        // Cambio en el valor de rst, tras 10 unidades de tiempo.
        #10;
        rst = 0;

        // Cambio en los valores de entrada, cada 40 unidades de tiempo.
        // Primer cambio, valor introducido 7609.
        #40;
        unidades_input = 4'd9;
        decenas_input = 4'd0;
        centenas_input = 4'd6;
        millares_input = 4'd7;
        listo = 1;
        #10;
        listo = 0;

        // Segundo cambio, valor introducido 3193.
        #40;
        unidades_input = 4'd3;
        decenas_input = 4'd9;
        centenas_input = 4'd1;
        millares_input = 4'd3;
        listo = 1;
        #10;
        listo = 0;

        // Tercer cambio, valor introducido 0094.
        #40;
        unidades_input = 4'd4;
        decenas_input = 4'd9;
        centenas_input = 4'd0;
        millares_input = 4'd0;
        listo = 1;
        #10;
        listo = 0;
        
        // Finalizacion de la prueba.
        #100;
        $finish;
        
    end

    // Sistema de guardado de los resultados del testbench.
    initial begin

        $dumpfile("module_seg_tb.vcd");
        $dumpvars(0,module_seg_tb);

    end 

endmodule 