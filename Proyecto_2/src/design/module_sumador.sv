module suma_aritmetica (
    input logic [11:0] num1,        // Número de tres dígitos en binario
    input logic [11:0] num2,
    input logic clk,                // Señal de reloj de 27 MHz
    input logic rst,  
    output logic [12:0] resultado              // Señal de reinicio asíncrono
);

    // Lógica de suma sincrónica con manejo de reset
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            resultado <= 13'd0;  // Resetear resultado a 0

        end else begin
            resultado<= num1 + num2;  // Sumar los números de entrada
        end
    end

    

endmodule

