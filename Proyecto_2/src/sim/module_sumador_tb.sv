module suma_tb;

// Declaración de señales
reg [11:0] num1;            // Entrada num1
reg [11:0] num2;            // Entrada num2
reg suma_btn;               // Botón de suma
reg clk;                    // Reloj
reg rst;                    // Reset
wire [12:0] resultado;      // Salida resultado

// Instancia del módulo
suma_aritmetica uut (
    .num1(num1),
    .num2(num2),
    .suma_btn(suma_btn),
    .clk(clk),
    .rst(rst),
    .resultado(resultado)
);

// Generación del reloj de 27 MHz
initial begin
    clk = 0;
    forever #18.52 clk = ~clk; // Periodo de reloj para 27 MHz
end

// Inicialización y test de entradas
initial begin
    // Inicializar señales
    rst = 1;  // Activar reset
    suma_btn = 0;
    num1 = 12'd0;
    num2 = 12'd0;

    // Desactivar reset
    #37;   // Esperar un ciclo de reloj
    rst = 0;

    // Test 1: Sumar 999 + 999
    #100;  // Esperar antes de establecer los valores
    num1 = 12'd999; 
    num2 = 12'd999; 
    suma_btn = 1;  // Presionar botón de suma
    #37;  // Esperar un ciclo de reloj
    suma_btn = 0;  // Soltar botón de suma

    // Comprobar resultado
    #37;
    if (resultado !== 13'd1998) begin
        $display("Error: Resultado no es 1998 con (999, 999) -> Resultado: %b", resultado);
    end else begin
        $display("Test 1 Passed: 999 + 999 = %d", resultado);
    end

    // Test 2: Sumar 800 + 300
    #100;
    num1 = 12'd800; 
    num2 = 12'd300; 
    suma_btn = 1;  
    #37; 
    suma_btn = 0;  

    // Comprobar resultado
    #37;
    if (resultado !== 13'd1100) begin
        $display("Error: Resultado no es 1100 con (800, 300) -> Resultado: %b", resultado);
    end else begin
        $display("Test 2 Passed: 800 + 300 = %d", resultado);
    end

    // Test 3: Sumar 500 + 0
    #37;
    num1 = 12'd500; 
    num2 = 12'd0; 
    suma_btn = 1;  
    #37; 
    suma_btn = 0;  

    // Comprobar resultado
    #37;
    if (resultado !== 13'd500) begin
        $display("Error: Resultado no es 500 con (500, 0) -> Resultado: %b", resultado);
    end else begin
        $display("Test 3 Passed: 500 + 0 = %d", resultado);
    end

    // Test 4: Sumar 0 + 600
    #37;
    num1 = 12'd0; 
    num2 = 12'd600; 
    suma_btn = 1;  
    #37; 
    suma_btn = 0;  

    // Comprobar resultado
    #37;
    if (resultado !== 13'd600) begin
        $display("Error: Resultado no es 600 con (0, 600) -> Resultado: %b", resultado);
    end else begin
        $display("Test 4 Passed: 0 + 600 = %d", resultado);
    end

    // Test 5: Sumar 0 + 0
    #37;
    num1 = 12'd0; 
    num2 = 12'd0; 
    suma_btn = 1;  
    #37; 
    suma_btn = 0;  

    // Comprobar resultado
    #37;
    if (resultado !== 13'd0) begin
        $display("Error: Resultado no es 0 con (0, 0) -> Resultado: %b", resultado);
    end else begin
        $display("Test 5 Passed: 0 + 0 = %d", resultado);
    end

    // Finalizar la simulación
    $finish;
end

    initial begin

        $dumpfile("sumador_tb.vcd");
        $dumpvars(0,suma_tb);

    end 

endmodule


