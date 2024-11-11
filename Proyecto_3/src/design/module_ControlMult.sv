module UnidadControl(
    input clk,                    
    input rst,                 
    input valid,                   
    input [2:0] contador,           
    input estado_actual,            // Añadido como entrada
    output reg sig_estado,          
    output reg [2:0] sig_contador,  
    output reg sig_done          
);
    // Estados de la máquina de estados
    localparam ESPERA = 1'b0;       
    localparam MULTIPLICAR = 1'b1;   

    // Lógica combinacional para el control
    always @(*) begin
        case(estado_actual)
            ESPERA: begin
                sig_contador = 3'b0;          
                sig_done = 1'b0;           
                sig_estado = valid ? MULTIPLICAR : estado_actual;
            end
            MULTIPLICAR: begin
                sig_contador = contador + 1'b1;
                sig_done = (contador == 3'd7) ? 1'b1 : 1'b0;
                sig_estado = (contador == 3'd7) ? ESPERA : estado_actual;
            end
            default: begin
                sig_contador = 3'b0;
                sig_done = 1'b0;
                sig_estado = ESPERA;
            end
        endcase
    end
endmodule