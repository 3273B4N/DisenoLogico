module suma_aritmetica(
    input logic clk,                // Reloj
    input logic rst,                // Reset sincrónico
    input logic [11:0] num1,        // Número 1 (12 bits)
    input logic [11:0] num2,        // Número 2 (12 bits)
    input logic suma_btn,           // Botón de suma
    output reg [12:0] resultado     // Resultado de la operación
);

    // Definición de los estados
    typedef enum logic [1:0] {
        IDLE = 2'b00,         // Estado idle
        SUMA = 2'b01          // Estado de suma
    } state_t;

    state_t estado_actual, estado_siguiente; // Estado actual y siguiente

    // Máquina de estados secuencial
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            estado_actual <= IDLE;   // Reset, volvemos a estado IDLE
            resultado <= 13'b0;      // Reset del resultado
        end else begin
            estado_actual <= estado_siguiente;  // Avanzamos al estado siguiente
        end
    end

    // Lógica combinacional para el próximo estado y las salidas
    always_comb begin
        // Por defecto, mantenemos el estado actual y el resultado
        estado_siguiente = estado_actual;

        case (estado_actual)
            IDLE: begin
                // Si se presiona el botón de suma
                if (suma_btn) begin
                    estado_siguiente = SUMA; // Pasamos al estado de suma
                end
            end

            SUMA: begin
                // Calculamos la suma de num1 y num2
                resultado = {1'b0, num1} + {1'b0, num2}; // Aseguramos que suma sea de 13 bits
                estado_siguiente = IDLE; // Volvemos a IDLE después de sumar
            end

            default: begin
                estado_siguiente = IDLE;
            end
        endcase
    end
endmodule



