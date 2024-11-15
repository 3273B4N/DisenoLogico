module module_antirebote (
    input logic clk,                // Señal de reloj
    input logic rst,                // Señal de reset
    input logic [3:0] colin,        // Entrada de 4 botones con rebote (activa-baja)
    output logic [3:0] colo,        // Salida de 4 botones sin rebote
    output logic listoAR            // Flag que indica que tods los botones son estables
);

    // Constantes y parámetros
    parameter integer DEBOUNCE_TIME = 20; // Tiempo de anti-rebote (ajustar según frecuencia del reloj)

    // Registros internos
    logic [3:0] prev_colin;         // Valor previo de la entrada
    logic [3:0] debounce_reg;       // Registro para almacenar el valor de entrada durante el anti-rebote
    logic estable;                  // Señal interna para indicar estabilidad
    logic estable_prev;             // Estado anterior de la señal estable
    integer counter;                // Contador para el tiempo de anti-rebote

    // Procesamiento de anti-rebote
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reinicio de tods los registros
            prev_colin <= 4'b1111;  // Estado inicial en alto (sin presionar, lógica activa-baja)
            debounce_reg <= 4'b1111;
            colo <= 4'b1111;        // Salida inicial en alto (sin presionar)
            counter <= 0;
            estable <= 1'b0;
            estable_prev <= 1'b0;
            listoAR <= 1'b0;
        end else begin
            // Actualizar el estado previo de estable
            estable_prev <= estable;
            
            // Detecta un cambio en la entrada
            if (colin != prev_colin) begin
                // Reinicia el contador y almacena el nuevo valor en debounce_reg
                counter <= 0;
                debounce_reg <= colin;
                estable <= 1'b0;
            end else begin
                // Si la entrada es estable, incrementa el contador
                if (counter < DEBOUNCE_TIME) begin
                    counter <= counter + 1;
                end else begin
                    // Si se alcanza el tiempo de anti-rebote, actualiza la salida estable
                    colo <= debounce_reg;
                    estable <= 1'b1;
                end
            end

            // Genera un pulso de un ciclo cuando se alcanza la estabilidad
            listoAR <= estable && !estable_prev;

            // Actualiza el valor previo de la entrada
            prev_colin <= colin;
        end
    end

endmodule


