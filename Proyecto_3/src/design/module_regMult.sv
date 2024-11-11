// Módulo de Banco de Registros
module ShiftReg(
    input clk,
    input rst,
    input signed [15:0] sig_resultado,
    input sig_done,
    input sig_estado,
    input [1:0] sig_temp,
    input [2:0] sig_contador,
    output reg signed [15:0] resultado,
    output reg done,
    output reg estado_actual,
    output reg [1:0] temp,
    output reg [2:0] contador
);
    // Actualización síncrona de registros
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            // rst de los registros
            resultado <= 16'd0;
            done <= 1'b0;
            estado_actual <= 1'b0;
            temp <= 2'd0;
            contador <= 3'd0;
        end
        else begin
            // Actualización normal de registros
            resultado <= sig_resultado;
            done <= sig_done;
            estado_actual <= sig_estado;
            temp <= sig_temp;
            contador <= sig_contador;
        end
    end
endmodule
