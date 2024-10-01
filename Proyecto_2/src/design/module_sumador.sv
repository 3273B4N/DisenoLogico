module suma_aritmetica(
    input clk,                // Reloj
    input rst,                // Reset sincrónico
    input [11:0] num1,        // Número 1 (12 bits)
    input [11:0] num2,        // Número 2 (12 bits)
    input suma_btn,            // Botón de suma
    output reg [12:0] resultado // Resultado de la operación
);

    // Definición de los estados
    typedef enum logic [1:0] {
        IDLE = 2'b00,         // Estado idle
        SUMA = 2'b01          // Estado de suma
    } state_t;

    state_t estado_actual, estado_siguiente; // Estado actual y siguiente

    // Señales auxiliares
    wire num1_valido, num2_valido;  // Señales para verificar si num1 y num2 son válidos

    // Detectamos si num1 o num2 tienen un valor válido distinto de 0
    assign num1_valido = (num1 != 12'b0);
    assign num2_valido = (num2 != 12'b0);

    // Máquina de estados secuencial
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            estado_actual <= IDLE;   // Reset, volvemos a estado IDLE
            resultado <= 12'b0;      // Reset del resultado
        end else begin
            estado_actual <= estado_siguiente;  // Avanzamos al estado siguiente
        end
    end

    // Lógica combinacional para el próximo estado y las salidas
    always @(*) begin
        // Por defecto, mantenemos el estado actual y el resultado
        estado_siguiente = estado_actual;

        case (estado_actual)
            IDLE: begin
                // Si se presiona el botón de suma
                if (suma_btn) begin
                    // Si ambos números son válidos, pasamos al estado de suma
                    if (num1_valido && num2_valido) begin
                        estado_siguiente = SUMA;
                    end
                end
                // En estado IDLE, si no hay ambos valores, el resultado es el número válido o cero
                if (num1_valido && !num2_valido) begin
                    resultado = num1;
                end else if (!num1_valido && num2_valido) begin
                    resultado = num2;
                end else if (!num1_valido && !num2_valido) begin
                    resultado = 12'b0;
                end
            end

            SUMA: begin
                // Calculamos la suma de num1 y num2
                resultado = num1 + num2;

                // Si se presiona el botón de suma nuevamente o hay un nuevo valor en num1 o num2,
                // volvemos a IDLE para revisar los valores.
                if (suma_btn || !num1_valido || !num2_valido) begin
                    estado_siguiente = IDLE;
                end
            end

            default: begin
                estado_siguiente = IDLE;
            end
        endcase
    end
endmodule










