module module_teclado_detector (
    input logic clk,
    input logic rst,
    input logic [3:0] row,           // Fila de entrada del teclado
    input logic [3:0] column,        // Columna de entrada del teclado
    output reg [3:0] key_pressed      // Salida para indicar la tecla presionada
);

    logic [3:0] key_valid;           // Salida del módulo anti-rebote
    logic [3:0] sync_rows;           // Filas sincronizadas
    logic [3:0] sync_columns;        // Columnas sincronizadas
    logic clk_div;                   // Reloj dividido a 1 MHz
    logic [13:0] counter;            // Contador para dividir la frecuencia

    // Contador para dividir el reloj de 27 MHz a 1 MHz
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 14'b0;           // Reiniciar el contador
            clk_div <= 1'b0;            // Inicializar el reloj dividido
        end else begin
            if (counter == 13'd13) begin // 27 MHz / 2 = 13.5 MHz, 13.5 MHz / 2 = 1 MHz
                clk_div <= ~clk_div;     // Cambiar el estado de clk_div
                counter <= 14'b0;        // Reiniciar el contador
            end else begin
                counter <= counter + 1'b1; // Incrementar el contador
            end
        end
    end

    // Instanciación del módulo sincronizador
    module_sincronizador sincronizador_inst (
        .clk(clk_div),                 // Usar el reloj dividido
        .rst(rst),
        .async_rows(row),              // Usar filas como entrada asíncrona
        .async_columns(column),         // Usar columnas como entrada asíncrona
        .sync_rows(sync_rows),         // Salida sincronizada de filas
        .sync_columns(sync_columns)     // Salida sincronizada de columnas
    );

    // Instanciación del módulo anti-rebote
    module_anti_rebote anti_rebote_inst (
        .clk(clk_div),                 // Usar el reloj dividido
        .rst(rst),
        .rows(sync_rows),              // Usar filas sincronizadas
        .columns(sync_columns),        // Usar columnas sincronizadas
        .key_out(key_valid)            // Salida validada
    );

    // Control del barrido de filas y detección de teclas
    always_ff @(posedge clk_div or posedge rst) begin
        if (rst) begin
            key_pressed <= 4'b0000;      // Inicializa en cero
        end else begin
            // Solo procesar si hay teclas validas presionadas
            if (~key_valid == 4'b0000) begin // Si hay teclas presionadas (se espera que key_valid sea bajo)
                case (sync_rows)
                    4'b1110: begin // Fila 0 activa
                        case (sync_columns)
                            4'b1110: key_pressed <= 4'd1;  // Tecla 1
                            4'b1101: key_pressed <= 4'd2;  // Tecla 2
                            4'b1011: key_pressed <= 4'd3;  // Tecla 3
                            4'b0111: key_pressed <= 4'd10; // Tecla A
                            default: key_pressed <= 4'b0000; // Sin tecla presionada
                        endcase
                    end
                    4'b1101: begin // Fila 1 activa
                        case (sync_columns)
                            4'b1110: key_pressed <= 4'd4;  // Tecla 4
                            4'b1101: key_pressed <= 4'd5;  // Tecla 5
                            4'b1011: key_pressed <= 4'd6;  // Tecla 6
                            4'b0111: key_pressed <= 4'd11; // Tecla B
                            default: key_pressed <= 4'b0000; // Sin tecla presionada
                        endcase
                    end
                    4'b1011: begin // Fila 2 activa
                        case (sync_columns)
                            4'b1110: key_pressed <= 4'd7;  // Tecla 7
                            4'b1101: key_pressed <= 4'd8;  // Tecla 8
                            4'b1011: key_pressed <= 4'd9;  // Tecla 9
                            4'b0111: key_pressed <= 4'd12; // Tecla C
                            default: key_pressed <= 4'b0000; // Sin tecla presionada
                        endcase
                    end
                    4'b0111: begin // Fila 3 activa
                        case (sync_columns)
                            4'b1110: key_pressed <= 4'd14; // Tecla *
                            4'b1101: key_pressed <= 4'd0;  // Tecla 0
                            4'b1011: key_pressed <= 4'd15; // Tecla #
                            4'b0111: key_pressed <= 4'd13; // Tecla D
                            default: key_pressed <= 4'b0000; // Sin tecla presionada
                        endcase
                    end
                    default: key_pressed <= 4'b0000; // Sin tecla presionada
                endcase
            end else begin
                key_pressed <= 4'b0000; // Sin tecla presionada
            end
        end
    end

endmodule
