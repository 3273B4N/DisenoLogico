
module module_BCDBin(
    input wire clk,                // Señal de reloj
    input wire rst,                // Reset asíncrono activo en alto
    input wire listo1,             // Señales de listo 
    input wire listo2,
    input wire [7:0] num1, num2,  // Entradas BCD (2 dígitos para cada número)
    output reg [7:0] num1O, num2O, // Salidas binarias
    output reg listo0             // Señal de listo0
);

    // Extraer dígitos BCD para num1
    wire [3:0] decenas1 = num1[7:4];
    wire [3:0] unidades1 = num1[3:0];
    
    // Extraer dígitos BCD para num2
    wire [3:0] decenas2 = num2[7:4];
    wire [3:0] unidades2 = num2[3:0];
    
    // Señales para el cálculo usando shifters
    wire [7:0] decenas1_ext = {4'b0000, decenas1};
    wire [7:0] shift_3_1_num1 = decenas1_ext << 3;  // decenas1 * 8
    wire [7:0] shift_1_num1 = decenas1_ext << 1;     // decenas1 * 2
    wire [7:0] decenas1_x10 = shift_3_1_num1 + shift_1_num1;  // (decenas1 * 8) + (decenas1 * 2)

    wire [7:0] decenas2_ext = {4'b0000, decenas2};
    wire [7:0] shift_3_1_num2 = decenas2_ext << 3;  // decenas2 * 8
    wire [7:0] shift_1_num2 = decenas2_ext << 1;     // decenas2 * 2
    wire [7:0] decenas2_x10 = shift_3_1_num2 + shift_1_num2;  // (decenas2 * 8) + (decenas2 * 2)

    reg [1:0] state; // 00: esperando, 01: leyendo num1, 10: leyendo num2, 11: terminado

    // Estados
    localparam WAIT = 2'b00, NUM1 = 2'b01, NUM2 = 2'b10, DONE = 2'b11;
    reg [7:0] prev_num1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset asíncrono
            num1O <= 8'b0;
            num2O <= 8'b0;
            listo0 <= 1'b0;
  
            state <= WAIT;
            prev_num1<=8'b0;
        end else begin
            case (state)
                WAIT: begin
                    listo0=0;
                    // Si num1 es distinto de 0, empieza la decodificación de num1
                    if (num1 != prev_num1) begin
                        state <= NUM1;  // Cambiar al estado de lectura de num1
                    end
                end
                
                NUM1: begin
                    // Verificar si los dígitos BCD de num1 son válidos (0-9)
                    if (decenas1 <= 4'd9 && unidades1 <= 4'd9) begin

                        if(decenas1==4'd0) begin
                            num1O <= unidades1;
                        end else begin
                        // Realizar la conversión para num1
                        num1O <= decenas1_x10 + {4'b0000, unidades1};
                        
                        // Mantenerse en NUM1 hasta que se active listo2 para comenzar con num2
                        if (listo1) begin
                            state <= NUM2;  // Cambiar al estado de lectura de num2
                            prev_num1<=num1;
                        end else begin
                            state <= NUM1;  // Continuar en NUM1 hasta que listo1 se active
                        end
                        end
                    end else begin
                        // Si los dígitos BCD no son válidos
                        num1O <= 8'b0;
                        num2O <= 8'b0;
                        listo0 <= 1'b0;
                        state <= DONE;  // Pasar al estado de DONE por error
                    end
                end

                NUM2: begin
                    // Verificar si los dígitos BCD de num1 son válidos (0-9)
                    if (decenas2 <= 4'd9 && unidades2 <= 4'd9) begin
                        if(decenas2==4'd0) begin
                            num2O <= unidades2;
                        end else begin
                        // Realizar la conversión para num1
                        num2O <= decenas2_x10 + {4'b0000, unidades2};
                        
                        // Mantenerse en NUM2 hasta que se active listo2 para comenzar con terminar
                        if (listo2) begin
                            state <= DONE;  // Cambiar al estado de lectura de DONE
                        end else begin
                            state <= NUM2;  // Continuar en NUM2 hasta que listo2 se active
                        end
                        end
                    end else begin
                        // Si los dígitos BCD no son válidos
                        num1O <= 8'b0;
                        num2O <= 8'b0;
                        listo0 <= 1'b0;
                        state <= DONE;  // Pasar al estado de DONE por error
                    end
                end

                DONE: begin
                    // Cuando los dos números se hayan decodificado, activar listo0
                    listo0 <= 1'b1;
                    state <= WAIT;  // Volver a esperar por un nuevo número
                end
            endcase
        end
    end

endmodule





