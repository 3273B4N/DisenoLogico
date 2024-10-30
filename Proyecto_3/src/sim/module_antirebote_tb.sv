`timescale 1ns/1ps

module module_antirebote_tb;

   `timescale 1ns / 1ps


    // Señales para conectar al módulo
    logic clk;
    logic rst;
    logic [3:0] rows;
    logic [3:0] columns;
    logic [3:0] key_out;

    // Instancia del módulo
    module_anti_rebote uut (
        .clk(clk),
        .rst(rst),
        .rows(rows),
        .columns(columns),
        .key_out(key_out)
    );

    // Generación del reloj
    initial begin
        clk = 0;
        forever #18.5 clk = ~clk; // 27 MHz
    end

    // Estímulos de prueba
    initial begin
        // Reset inicial
        rst = 1;
        rows = 4'b1111;
        columns = 4'b1111;
        #50 rst = 0;

        // Caso 1: Simula la pulsación de una tecla en una fila sin rebotes
        rows = 4'b1110; // Pulsación en la primera fila
        columns = 4'b1110; // Pulsación en la primera columna
        #500;

        // Caso 2: Simula rebote en las filas
        rows = 4'b1110;
        columns = 4'b1110;
        #100 rows = 4'b1111;
        #100 rows = 4'b1110;
        #500;

        // Caso 3: Simula rebote en las columnas
        rows = 4'b1110;
        columns = 4'b1110;
        #100 columns = 4'b1111;
        #100 columns = 4'b1110;
        #500;

        // Caso 4: Simula múltiples teclas presionadas (sin rebote)
        rows = 4'b1100; // Presión en dos filas
        columns = 4'b1100; // Presión en dos columnas
        #500;

        // Caso 5: Todas las teclas sueltas
        rows = 4'b1111;
        columns = 4'b1111;
        #500;

        // Fin de la simulación
        $stop;
    end


    initial begin
        $dumpfile("module_antirebote_tb.vcd");
        $dumpvars(0, module_antirebote_tb);
    end

endmodule
