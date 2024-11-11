// Testbench del modulo top general de la tarea 3, modulo en uut module_seg.

// Declaracion de la unidad de tiempo.
`timescale 1ns/1ps

module module_top_general_tb;

    // Declaracion de las señales para el testbench.

    logic clk;
    logic rst;
    logic [3:0] column;
    logic [3:0] row;
    logic [6:0] seg;
    logic [3:0] transis;

    module_top_general uut(

        .clk(clk),
        .rst(rst),
        .column(column),
        .row(row),
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

        // Cambio en el valor de rst, tras 10 unidades de tiempo.
        #10;
        rst = 0;


        
        // Finalizacion de la prueba.
        #1000;
        $finish;
        
    end

    // Sistema de guardado de los resultados del testbench.
    initial begin

        $dumpfile("module_top_general_tb.vcd");
        $dumpvars(0,module_top_general_tb);

    end 


endmodule 