`timescale 1ns/1ps


module module_dipswitch_tb; 

    // Declaración de señales
    logic clk;
    logic rst;
    logic ag, bg, cg, dg; // Entradas del decoder
    logic [11:0] first_num; // Salida del primer número
    logic [11:0] second_num; // Salida del segundo número

    // Instanciar el módulo bajo prueba
    module_teclado uut (
        .clk(clk),
        .rst(rst),
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .first_num(first_num),
        .second_num(second_num)
    );

    // Generador de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Reloj de 10 unidades de tiempo
    end

    // Inicialización de señales
    initial begin
        rst = 1; // Aplicar reset
        ag = 0; bg = 0; cg = 0; dg = 0;
        #10;
        rst = 0; // Quitar reset

        // Probar el primer número (3 dígitos)
        #10; {ag, bg, cg, dg} = 4'b0000; // 0 en Gray
        #10; {ag, bg, cg, dg} = 4'b0001; // 1 en Gray
        #10; {ag, bg, cg, dg} = 4'b0011; // 2 en Gray
        #10; {ag, bg, cg, dg} = 4'b0010; // 3 en Gray
        #10; {ag, bg, cg, dg} = 4'b0100; // 4 en Gray

        // Cambiar a segundo número después de completar el primer número
        #10; {ag, bg, cg, dg} = 4'b0101; // 5 en Gray
        #10; {ag, bg, cg, dg} = 4'b0111; // 6 en Gray
        #10; {ag, bg, cg, dg} = 4'b0110; // 7 en Gray

        // Verificar resultados
        #10;
        $display("Final first_num: %b (dec: %0d)", first_num, first_num);
        $display("Final second_num: %b (dec: %0d)", second_num, second_num);

        // Mostrar el número final en decimal
        $display("Final first_num in decimal: %0d", first_num);
        $display("Final second_num in decimal: %0d", second_num);

        // Finalizar simulación
        #10;
        $finish;
    end

    // Monitoreo de señales
    initial begin
        $monitor("Time: %0t | first_num: %b | second_num: %b", $time, first_num, second_num);
    end


    initial begin
        $dumpfile("module_dipswitch_tb.vcd");
        $dumpvars(0, module_dipswitch_tb);
    end

endmodule


   