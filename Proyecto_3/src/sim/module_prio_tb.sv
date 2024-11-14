// Testbench del modulo en uut module_prio.

// Declaracion de la unidad de tiempo.
`timescale 1ns/1ps

module module_prio_tb;
    
    // Declaracion de las señales para el testbench.
    logic clk;
    logic rst;
    logic [7:0] num_1;
    //logic sig_1;
    logic [7:0] num_2;
    //logic sig_2;
    logic listo_1;
    logic listo;
    logic [15:0] num_mul;
    //logic sig_mul;
    logic [15:0] numero_output;
    //logic signo_output;

    // Declaracion de las instancias para el testbench, unidad bajo prueba "uut".
    module_prio uut (

        .clk(clk),
        .rst(rst),
        .num_1(num_1),
        //.sig_1(sig_1),
        .num_2(num_2),
        //.sig_2(sig_2),
        .listo_1(listo_1),
        .listo(listo),
        .num_mul(num_mul),
        //.sig_mul(sig_mul),
        .numero_output(numero_output)
        //.signo_output(signo_output)

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
        rst = 1;

        // Cambio en el valor de rst, tras 10 unidades de tiempo.
        #10;
        rst = 0;

        // Primera prueba
        #10;
        num_1 = 16'd15;
        //sig_1 = 0;
        num_2 = 16'd10;
        //sig_2 = 1;
        num_mul = 16'd150;
        //sig_mul = 1;
        #10;
        listo_1 = 1;
        #10;
        listo = 1;
        
        // Finalizacion de la prueba.
        #100;
        $finish;
        
    end

    // Sistema de guardado de los resultados del testbench.
    initial begin

        $dumpfile("module_prio_tb.vcd");
        $dumpvars(0,module_prio_tb);

    end 
    
endmodule