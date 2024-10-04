`timescale 1ns/1ps

module module_dipswitch_tb; 


  

    logic clk;
    logic rst;
    logic ag, bg, cg, dg; // Entradas en código binario
    logic button; // Botón para agregar el dígito
    logic [11:0] first_num; // Salida para el primer número
    logic [11:0] second_num; // Salida para el segundo número

    // Instanciación del módulo
    module_dipswitch uut (
        .clk(clk),
        .rst(rst),
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .button(button),
        .first_num(first_num),
        .second_num(second_num)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 unidades de tiempo de período
    end

    // Secuencia de prueba
    initial begin
        // Inicialización
        rst = 1; // Activar reset
        button = 0;
        ag = 0; bg = 0; cg = 0; dg = 0; // Inicializar entradas
        #10;
        
        rst = 0; // Desactivar reset

        // Prueba para el primer número (ejemplo: 123)
        // 1 (0001)
        ag = 0; bg = 0; cg = 0; dg = 1; 
        button = 1; #10; // Presionar el botón
        button = 0; #10; // Liberar el botón

        // 2 (0010)
        ag = 0; bg = 0; cg = 1; dg = 0; 
        button = 1; #10; 
        button = 0; #10;

        // 3 (0011)
        ag = 0; bg = 0; cg = 1; dg = 1; 
        button = 1; #10; 
        button = 0; #10;

        // Prueba para el segundo número (ejemplo: 456)
        // 4 (0100)
        ag = 0; bg = 1; cg = 0; dg = 0; 
        button = 1; #10; 
        button = 0; #10;

        // 5 (0101)
        ag = 0; bg = 1; cg = 0; dg = 1; 
        button = 1; #10; 
        button = 0; #10;

        // 6 (0110)
        ag = 0; bg = 1; cg = 1; dg = 0; 
        button = 1; #10; 
        button = 0; #10;

        // 7 (0101)
        ag = 0; bg = 1; cg = 0; dg = 1; 
        button = 1; #10; 
        button = 0; #10;

        // 8 (0110)
        ag = 0; bg = 1; cg = 1; dg = 0; 
        button = 1; #10; 
        button = 0; #10;

        // Finalización de la simulación
        #10;
        $finish;
    end

    // Monitoreo de resultados
    initial begin
        $monitor("Time: %0t | first_num: %b | second_num: %b", $time, first_num, second_num);
    end



    


    initial begin
        $dumpfile("module_dipswitch_tb.vcd");
        $dumpvars(0, module_dipswitch_tb);
    end

endmodule


   