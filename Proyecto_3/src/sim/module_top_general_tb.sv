// Testbench del modulo top general de la tarea 3, modulo en uut module_seg.

// Declaracion de la unidad de tiempo.
`timescale 1ns / 1ps

module module_top_general_tb;

    // Señales para el módulo de prueba
    logic clk;
    logic rst;
    logic [3:0] column;
    logic [3:0] row;
    logic [6:0] seg;
    logic [3:0] transis;

    // Instancia del módulo top
    module_top_general uut (
        .clk(clk),
        .rst(rst),
        .column(column),
        .row(row),
        .seg(seg),
        .transis(transis)
    );

    // Generación del reloj
    always #5 clk = ~clk;

    // Procedimiento para generar el estímulo de entrada
    initial begin
        // Inicialización
        clk = 0;
        rst = 1;
        column = 4'b1111;
        row = 4'b1111;

        // Liberar el reset después de un ciclo de reloj
        #1000;
        rst = 0;

        // Simular entrada desde el teclado (ejemplo: 1* 2)
        
        // Ejemplo: Primer número (1)
        row = 4'b1110; column = 4'b1110; 
        #1000;
        row = 4'b1111; column = 4'b1111;
        #2000;

        // Confirmación de entrada
        row = 4'b1110; column = 4'b0111; // Presionando "Enter" para confirmar
        #1000;
        row = 4'b1111; column = 4'b1111;
        #2000;
        
        // Segundo número (2)
        row = 4'b1110; column = 4'b1101; 
        #1000;
        row = 4'b1111; column = 4'b1111;
        #2000;


        // Confirmación de entrada
        row = 4'b1101; column = 4'b0111; // Presionando "Enter" para confirmar
        #1000;
        row = 4'b1111; column = 4'b1111;
        #2000;
        
        
        
        
         initial begin
        $dumpfile("module_top_general_tb.vcd");
        $dumpvars(0, module_top_general_tb);
    end

        // Fin de la simulación
        $stop;
    end

endmodule
