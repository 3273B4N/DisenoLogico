// Testbench del subsistema 3, modulo en uut module_seg.

// Declaracion de la unidad de tiempo.
`timescale 1ns / 1ps

module module_seg_tb;

    // Declaracion de las señales para el testbench.
    logic clk;
    logic A, B, C, D;
    logic au, bu, cu, du, eu, fu, gu;
    logic ad, bd, cd, dd, ed, fd, gd;

    // Declaracion de las instancias para el testbench, unidad bajo prueba "uut".
    module_seg uut (
        .clk(clk),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .au(au),
        .bu(bu),
        .cu(cu),
        .du(du),
        .eu(eu),
        .fu(fu),
        .gu(gu),
        .ad(ad),
        .bd(bd),
        .cd(cd),
        .dd(dd),
        .ed(ed),
        .fd(fd),
        .gd(gd)
    );

    // Establecer el sistema del reloj, cada periodo es igual a 10 unidades de tiempo.
    always begin

        clk = 1; 
        #5;
        clk = 0;
        #5;

    end

    // Inicio de la prueba del modulo.
    initial begin

        // Valores iniciales de la prueba.
        A = 0;
        B = 0;
        C = 0;
        D = 0;

        // Cambio en los valores de entrada iniciales, cada 10 unidades de tiempo.
        // Primer cambio 
        #10;
        A = 0;
        B = 1;
        C = 1;
        D = 0;

        // Segundo cambio
        #10;
        A = 1;
        B = 0;
        C = 1;
        D = 0;

        // Tercer cambio
        #10;
        A = 1;
        B = 1;
        C = 0;
        D = 0;

        // Finalizacion de la prueba
        #10;
        $finish;
        
    end

    // Sistema de guardado de los resultados del testbench.
    initial begin

        $dumpfile("module_seg_tb.vcd");
        $dumpvars(0,module_seg_tb);

    end 

endmodule