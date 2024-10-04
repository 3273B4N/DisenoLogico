`timescale 1ns/1ps
module module_top_tb; 


    // Parámetros del testbench
    logic clk;
    logic rst;
    logic ag, bg, cg, dg; // Entradas del dip switch
    logic suma_btn; // Botón de suma
    logic button; // Botón para agregar el dígito
    logic [6:0] seg_unidades, seg_decenas, seg_centenas, seg_milesimas;

    // Instancia del módulo top
    top uut (
        .clk(clk),
        .rst(rst),
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .dg(dg),
        .suma_btn(suma_btn),
        .button(button),
        .seg_unidades(seg_unidades),
        .seg_decenas(seg_decenas),
        .seg_centenas(seg_centenas),
        .seg_milesimas(seg_milesimas)
    );

    // Generación del reloj
    initial begin
        clk = 0;
        forever #2 clk = ~clk; // Cambia cada 5 unidades de tiempo
    end

    // Proceso de prueba
    initial begin
        // Inicialización
        rst = 1;
        ag = 0; bg = 0; cg = 0; dg = 0; 
        suma_btn = 0;
        button = 0;

        // Esperar un tiempo para la estabilización
        #10;
        rst = 0; // Desactivar el reset

        // Primer número: 5 (0101)
        button = 0; // Presionar botón
        ag = 0; bg = 1; cg = 0; dg = 1; // Introducir 5
        #10; // Esperar
        button = 1; // Liberar botón
        #10; // Esperar estabilización

        // Segundo número: 3 (0011)
        button = 0; // Presionar botón
        ag = 0; bg = 0; cg = 1; dg = 1; // Introducir 3
        #10; // Esperar
        button = 1; // Liberar botón
        #10; // Esperar estabilización
        //Primer número: 5 (0101)
        button = 0; // Presionar botón
        ag = 0; bg = 1; cg = 0; dg = 1; // Introducir 5
        #10; // Esperar
        button = 1; // Liberar botón
        #10; // Esperar estabilización

        // Segundo número: 3 (0011)
        button = 1; // Presionar botón
        ag = 0; bg = 0; cg = 1; dg = 1; // Introducir 3
        #10; // Esperar
        button = 0; // Liberar botón
        #10; // Esperar estabilización
        //Primer número: 5 (0101)
        button = 1; // Presionar botón
        ag = 0; bg = 1; cg = 0; dg = 1; // Introducir 5
        #10; // Esperar
        button = 0; // Liberar botón
        #10; // Esperar estabilización

        // Segundo número: 3 (0011)
        button = 1; // Presionar botón
        ag = 0; bg = 0; cg = 1; dg = 1; // Introducir 3
        #10; // Esperar
        button = 0; // Liberar botón
        #10; // Esperar estabilización
        //Primer número: 5 (0101)
        button = 1; // Presionar botón
        ag = 0; bg = 1; cg = 0; dg = 1; // Introducir 5
        #10; // Esperar
        button = 0; // Liberar botón
        #10; // Esperar estabilización

        // Segundo número: 3 (0011)
        button = 1; // Presionar botón
        ag = 0; bg = 0; cg = 1; dg = 1; // Introducir 3
        #10; // Esperar
        button = 0; // Liberar botón
        #10; // Esperar estabilización

         // Segundo número: 3 (0011)
        button = 1; // Presionar botón
        ag = 0; bg = 0; cg = 1; dg = 1; // Introducir 3
        #10; // Esperar
        button = 0; // Liberar botón
        #10; // Esperar estabilización

         // Segundo número: 3 (0011)
        button = 1; // Presionar botón
        ag = 0; bg = 0; cg = 1; dg = 1; // Introducir 3
        #10; // Esperar
        button = 0; // Liberar botón
        #10; // Esperar estabilización

        // Realizar suma
        suma_btn = 1; // Presionar botón de suma
        #10; // Esperar
        suma_btn = 0; // Liberar botón
        #10; // Esperar estabilización

        // Verificar resultados
        // Esperar a que se complete la división
        #10;
        // Aquí puedes agregar chequeos adicionales para verificar los segmentos de salida


        // Finalizar la simulación
        $finish;
    end

    // Monitorear las salidas
    initial begin
        $monitor("Time: %0t | seg_unidades: %b | seg_decenas: %b | seg_centenas: %b | seg_milesimas: %b", 
                 $time, seg_unidades, seg_decenas, seg_centenas, seg_milesimas);
    end




    initial begin

        $dumpfile("module_top_tb.vcd");
        $dumpvars(0,module_top_tb);

    end

endmodule