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
 always begin
       clk = 0; #5;
       clk = 1; #5;
   end

     // Estímulos
    initial begin
       // Inicialización

       rst = 1;
       row = 4'b1111;
       column = 4'b1111;
       #2000;
       rst = 0;
       #2000;

       // Primera fila (1110)
       // Tecla 1
       row = 4'b1110;
       column = 4'b1110;
       #2000;
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #2000;
       
              // Tecla 1
       row = 4'b1110;
       column = 4'b1110;
       #3000;
      
             // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #2000;
       
       // Tecla A (10)
       row = 4'b1110;
       column = 4'b0111;
       #1000;
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;

       // Segunda fila (1101)
       // Tecla 4
       row = 4'b1101;
       column = 4'b1110;
       #1000;
       
        // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;

              // Segunda fila (1101)
       // Tecla 4
       row = 4'b1101;
       column = 4'b1110;
       #1000;

               // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;
       
       // Tecla B (11)
       row = 4'b1101;
       column = 4'b0111;
       #1000;
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #5000;

       rst = 1;
       #2000;
       rst = 0;
       #2000;

       // Primera fila (1110)
       // Tecla 1
       row = 4'b1110;
       column = 4'b1110;
       #2000;
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #2000;
       
              // Tecla 1
       row = 4'b1110;
       column = 4'b1110;
       #3000;
      
             // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #2000;
       
       // Tecla A (10)
       row = 4'b1110;
       column = 4'b0111;
       #1000;
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;

       // Segunda fila (1101)
       // Tecla 4
       row = 4'b1101;
       column = 4'b1110;
       #1000;
       
        // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;

              // Segunda fila (1101)
       // Tecla 4
       row = 4'b1101;
       column = 4'b1110;
       #1000;

               // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;
       
       // Tecla B (11)
       row = 4'b1101;
       column = 4'b0111;
       #1000;
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;


       
       // Fin de la simulación
       #5000;
       $finish;
   end


    //# Procedimiento para generar el estímulo de entrada


    initial begin
        $dumpfile("module_top_general_tb.vcd");
        $dumpvars(0, module_top_general_tb);
    end

endmodule
