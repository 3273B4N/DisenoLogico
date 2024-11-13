module ShiftReg(
    input clk,
    input rst,
    input signed [15:0] sig_resultado,
    input sig_done,
    input sig_estado,
    input [1:0] sig_temp,
    input [2:0] sig_contador,
    input clear_output,            // Entrada para limpiar salidas
    input valid,                   // Nueva entrada para detectar valid
    output reg signed [15:0] resultado,
    output reg done,
    output reg estado_actual,
    output reg [1:0] temp,
    output reg [2:0] contador
);
    // Registros adicionales para mantener valores
    reg signed [15:0] resultado_retenido;
    reg done_retenido;

    // Actualización síncrona de registros
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            resultado <= 16'd0;
            done <= 1'b0;
            estado_actual <= 1'b0;
            temp <= 2'd0;
            contador <= 3'd0;
            resultado_retenido <= 16'd0;
            done_retenido <= 1'b0;
        end
        else begin
            // Manejar señales de control
            estado_actual <= sig_estado;
            temp <= sig_temp;
            contador <= sig_contador;

            // Manejar resultado y done
            if (valid) begin
                // Reset inmediato cuando llega valid
                resultado <= 16'd0;
                done <= 1'b0;
                resultado_retenido <= 16'd0;
                done_retenido <= 1'b0;
            end
            else if (sig_done) begin
                // Nueva multiplicación completada
                resultado <= sig_resultado;
                done <= 1'b1;
                resultado_retenido <= sig_resultado;
                done_retenido <= 1'b1;
            end
            else if (!estado_actual) begin
                // En estado ESPERA, mantener valores retenidos
                resultado <= resultado_retenido;
                done <= done_retenido;
            end
            else begin
                // Durante la multiplicación, actualizar normalmente
                resultado <= sig_resultado;
                done <= 1'b0;
            end
        end
    end
endmodule
