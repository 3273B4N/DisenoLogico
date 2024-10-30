`timescale 1ns/1ps

module module_sin_tb;


    // Parámetros
    parameter CLK_PERIOD = 37; // Periodo de 27 MHz en nanosegundos (1 / 27MHz * 1e9)
    parameter SIM_DURATION = 5000; // Duración de la simulación en nanosegundos

    // Señales de entrada
    logic clk;
    logic rst;
    logic [3:0] async_rows;
    logic [3:0] async_columns;

    // Señales de salida
    logic [3:0] sync_rows;
    logic [3:0] sync_columns;

    // Instanciar el módulo
    module_sincronizador uut (
        .clk(clk),
        .rst(rst),
        .async_rows(async_rows),
        .async_columns(async_columns),
        .sync_rows(sync_rows),
        .sync_columns(sync_columns)
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
        async_rows = 4'b1111; // Inicialmente todas las filas inactivas
        async_columns = 4'b1111; // Inicialmente todas las columnas inactivas

        // Liberar el reset
        #50 rst = 0;

        // Probar diferentes configuraciones de filas y columnas
        // Fila 0 activa
        #100 async_rows = 4'b1110; async_columns = 4'b1111; // Fila 0 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1111; // Liberar filas

        // Fila 1 activa
        #100 async_rows = 4'b1101; async_columns = 4'b1111; // Fila 1 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1111; // Liberar filas

        // Fila 2 activa
        #100 async_rows = 4'b1011; async_columns = 4'b1111; // Fila 2 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1111; // Liberar filas

        // Fila 3 activa
        #100 async_rows = 4'b0111; async_columns = 4'b1111; // Fila 3 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1111; // Liberar filas

        // Probar columnas activas
        // Columna 0 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1110; // Columna 0 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1111; // Liberar columnas

        // Columna 1 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1101; // Columna 1 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1111; // Liberar columnas

        // Columna 2 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1011; // Columna 2 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1111; // Liberar columnas

        // Columna 3 activa
        #100 async_rows = 4'b1111; async_columns = 4'b0111; // Columna 3 activa
        #100 async_rows = 4'b1111; async_columns = 4'b1111; // Liberar columnas

        // Finalizar simulación
        #100 rst = 1; // Activar reset
        #50 $finish; // Terminar la simulación
    end






    initial begin
        $dumpfile("module_sin_tb.vcd");
        $dumpvars(0, module_sin_tb);
    end

endmodule
