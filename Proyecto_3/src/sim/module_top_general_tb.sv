
`timescale 1ms/1ps
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

    // Generación del reloj a 1 kHz
    always begin
       clk = 0; #0.5;   // 500,000 ns = 0.5 ms (bajo)
       clk = 1; #0.5;   // 500,000 ns = 0.5 ms (alto)
    end

    // Estímulos con tiempos ajustados para funcionar con el reloj dividido de 1 kHz
    initial begin
       // Inicialización
       rst = 1;
       row = 4'b1111;
       column = 4'b1111;
       #1000;   // Espera de 1 segundo para inicializar correctamente
       rst = 0;
       #1000;   // Espera de 1 segundo después de desactivar reset

       // Primera fila (1110)
       // Tecla 1
       row = 4'b1110;
       column = 4'b1110;
       #10000;   // 1 segundo de espera para presionar la tecla
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;   // 1 segundo de espera después de liberar la tecla
       
       // Tecla 2
       row = 4'b1110;
       column = 4'b1101;
       #1000;   // 1 segundo para mantener presionada la tecla
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;   // 1 segundo después de liberar la tecla
       
       // Tecla A (10)
       row = 4'b1110;
       column = 4'b0111;
       #1000;   // 1 segundo de espera para la tecla A
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;   // 1 segundo después de liberar la tecla

       // Segunda fila (1101)
       // Tecla 4
       row = 4'b1101;
       column = 4'b1110;
       #1000;   // 1 segundo para la tecla 4
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;   // 1 segundo de espera

       // Segunda fila (1101)
      // Tecla 2
       row = 4'b1110;
       column = 4'b1101;
       #1000;
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;   // 1 segundo de espera

       // Tecla B (11)
       row = 4'b1101;
       column = 4'b0111;
       #1000;   // 1 segundo para la tecla B
       // Liberar tecla
       row = 4'b1111;
       column = 4'b1111;
       #1000;   // 1 segundo de espera

       #1000
       rst = 1;
       #1000
       rst = 0;
       #1000; 

       // Fin de la simulación después de 10 segundos
       #20000;  // 10 segundos de espera antes de finalizar
       $finish;
    end

    // Generación de archivos de simulación
    initial begin
        $dumpfile("module_top_general_tb.vcd");
        $dumpvars(0, module_top_general_tb);
    end

endmodule


