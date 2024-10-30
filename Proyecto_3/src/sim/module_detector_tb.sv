`timescale 1ns/1ps

module module_detector_tb;



    // Parámetros
    parameter CLK_PERIOD = 37; // Periodo de 27 MHz en nanosegundos (1 / 27MHz * 1e9)
    parameter SIM_DURATION = 5000; // Duración de la simulación en nanosegundos

    // Señales de entrada
    logic clk;
    logic rst;
    logic [3:0] row;
    logic [3:0] column;

    // Señales de salida
    logic [3:0] key_pressed;

    // Instanciar el módulo
    module_teclado_detector uut (
        .clk(clk),
        .rst(rst),
        .row(row),
        .column(column),
        .key_pressed(key_pressed)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Cambiar el estado del reloj
    end

    // Generar la secuencia de prueba
    initial begin
        // Inicializar señales
        rst = 1;
        row = 4'b1111; // Inicialmente todas las filas inactivas
        column = 4'b1111; // Inicialmente todas las columnas inactivas

        // Liberar el reset
        #500 rst = 0;

        // Probar diferentes teclas presionadas
        // Tecla 1
        #1000 row = 4'b1110; column = 4'b1110; // Tecla 1 presionada
        #1000 row = 4'b1111; column = 4'b1111; // Liberar tecla

        // Tecla 2
        #1000 row = 4'b1110; column = 4'b1101; // Tecla 2 presionada
        #1000 row = 4'b1111; column = 4'b1111; // Liberar tecla

        // Tecla 3
        #1000 row = 4'b1110; column = 4'b1011; // Tecla 3 presionada
        #1000 row = 4'b1111; column = 4'b1111; // Liberar tecla

        // Tecla A
        #1000 row = 4'b1110; column = 4'b0111; // Tecla A presionada
        #1000 row = 4'b1111; column = 4'b1111; // Liberar tecla


        // Finalizar simulación
        #10000 rst = 1; // Activar reset
        #50000 $finish; // Terminar la simulación
    end






    initial begin
        $dumpfile("module_detector_tb.vcd");
        $dumpvars(0, module_detector_tb);
    end

endmodule
