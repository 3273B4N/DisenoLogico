`timescale 1ns / 1ps
module suma_tb();

    // Declaración de señales de prueba
    logic [11:0] num1;        // Primer número de prueba
    logic [11:0] num2;        // Segundo número de prueba
    logic clk;                // Señal de reloj de prueba
    logic rst;                // Señal de reinicio de prueba

    // Salidas del DUT (Device Under Test)
    logic [12:0] resultado;   // Resultado de la suma


    // Instanciar el módulo suma_aritmetica
    suma_aritmetica dut (
        .num1(num1),
        .num2(num2),
        .clk(clk),
        .rst(rst),
        .resultado(resultado)
    );


    // Proceso de prueba
    initial begin

        // Inicializar las señales
        rst= 1;  // Activa el reset
        clk=0;
        num1 = 12'd0;
        num2 = 12'd0;
        #50;        // Esperar algunos ciclos de reloj
        
        rst = 0;  // Desactiva el reset

        // Prueba 1: num1 = 123, num2 = 456
        num1 = 12'd123;  // Primer número en binario
        num2 = 12'd456;  // Segundo número en binario
        #50;  // Esperar algunos ciclos de reloj

        // Prueba 2: num1 = 789, num2 = 987
        num1 = 12'd789;
        num2 = 12'd987;
        #50;

        // Prueba 3: num1 = 999, num2 = 1
        num1= 12'd999;
        num2 = 12'd1;
        #50;

        // Prueba 4: Reiniciar el sistema
        rst = 1;
        #50;
        rst = 0;
        #50;
     
        $finish;
    end
 // Generar el reloj de prueba
    always begin
        clk = ~clk;
        #18.518; // 27 MHz: periodo de 37.037 ns (18.518 ns en flanco positivo y negativo)
    end

initial begin
    $dumpfile("sumador_tb.vcd");
    $dumpvars(0,suma_tb);
    end
endmodule
