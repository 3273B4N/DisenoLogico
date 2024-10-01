`timescale 1ns/1ps
module module_top_tb; 


      // Parámetros de tiempo
    localparam CLK_PERIOD = 37; // Periodo del reloj (en tiempo de simulación)

    // Señales del testbench
    logic clk;
    logic rst;
    logic ag, bg, cg, dg; // Entradas del dip switch
    logic [6:0] seg_unidades;
    logic [6:0] seg_decenas;
    logic [6:0] seg_centenas;
    logic [6:0] seg_milesimas;

    // Señales internas
    logic suma_btn;

    // Instanciar el módulo top
    module_top uut (
        .clk(clk),
        .rst(rst),
        .ag(ag),
        .bg(bg),
        .cg(cg),
        .suma_btn(suma_btn),
        .seg_unidades(seg_unidades),
        .seg_decenas(seg_decenas),
        .seg_centenas(seg_centenas),
        .seg_milesimas(seg_milesimas)
    );

    // Generar señal de reloj
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Cambiar el estado del reloj
    end

    // Proceso de prueba
    initial begin
        // Inicializar señales
        rst = 1;
        ag = 0; bg = 0; cg = 0; dg = 0; // Inicializar switches
        suma_btn = 0;

        // Activar el reinicio
        #20 rst = 0; // Desactivar reinicio después de 20 unidades de tiempo

        #10; {ag, bg, cg, dg} = 4'b0000; // 0 en Gray
        #10; {ag, bg, cg, dg} = 4'b0001; // 1 en Gray
        #10; {ag, bg, cg, dg} = 4'b0011; // 2 en Gray
        #10; {ag, bg, cg, dg} = 4'b0010; // 3 en Gray
        #10; {ag, bg, cg, dg} = 4'b0100; // 4 en Gray

        #20;

        // Entrar el segundo número: 456 (código gray)
        #10; {ag, bg, cg, dg} = 4'b0101; // 5 en Gray
        #10; {ag, bg, cg, dg} = 4'b0111; // 6 en Gray
        #10; {ag, bg, cg, dg} = 4'b0110; // 7 en Gray
        #20;

        // Presionar el botón de suma

        suma_btn = 1;
        #20; // Esperar un ciclo para que se procese la suma
        suma_btn = 0;

        // Esperar un tiempo para observar el resultado
        #100;

        // Finalizar la simulación
        $finish;
    end


    initial begin

        $dumpfile("module_top_tb.vcd");
        $dumpvars(0,module_top_tb);

    end

endmodule