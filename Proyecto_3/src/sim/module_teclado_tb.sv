`timescale 1ns/1ps

module module_teclado_tb;




    // Parámetros de simulación
    localparam CLK_PERIOD = 37;  // Período del reloj en ns (27 MHz)

    // Señales de entrada
    logic clk;
    logic rst;
    logic [3:0] row;

    // Señales de salida
    logic [3:0] col;
    logic [7:0] first_num;
    logic [7:0] second_num;

    // Instancia del módulo a probar
    module_teclado uut (
        .clk(clk),
        .rst(rst),
        .col(col),
        .row(row),
        .first_num(first_num),
        .second_num(second_num)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;  // Cambia cada medio período
    end

    // Procedimiento inicial
    initial begin
        // Inicialización
        rst = 1;
        row = 4'b1111; // Ninguna tecla presionada (todas las filas altas)
        #1000;
        rst = 0; // Quitar reset

        // Simular la presión de teclas para el primer número
        // Presionar tecla '1' (fila 0, columna 0)
        row = 4'b1110; // '1' presionada
        #1000;  // Esperar un ciclo

        // Presionar tecla '2' (fila 0, columna 1)
        row = 4'b1101; // '2' presionada
        #1000;  // Esperar un ciclo

        // Simular la presión de tecla 'A' para pasar al segundo número
        row = 4'b0111; // 'A' presionada
        #1000;  // Esperar un ciclo

        // Simular la presión de teclas para el segundo número
        // Presionar tecla '3' (fila 0, columna 2)
        row = 4'b1011; // '3' presionada
        #1000;  // Esperar un ciclo

        // Presionar tecla '4' (fila 0, columna 3)
        row = 4'b0111; // '4' presionada
        #1000;  // Esperar un ciclo

        // Presionar tecla 'B' para establecer el segundo número como negativo
        row = 4'b1110; // 'B' presionada
        #1000;  // Esperar un ciclo

        // Finalizar simulación
        row = 4'b1111; // Ninguna tecla presionada
        #2000; // Esperar un poco
        $finish;
    end

   

    initial begin
        $dumpfile("module_teclado_tb.vcd");
        $dumpvars(0, module_teclado_tb);
    end

endmodule
