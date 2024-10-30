module module_sincronizador (
    input logic clk,                     // Reloj
    input logic rst,                     // Reset
    input logic [3:0] async_rows,        // Filas de entrada asíncronas
    input logic [3:0] async_columns,     // Columnas de entrada asíncronas
    output logic [3:0] sync_rows,        // Filas de salida sincronizadas
    output logic [3:0] sync_columns       // Columnas de salida sincronizadas
);

    logic [1:0] shift_reg_rows[3:0];     // Registros de desplazamiento para filas
    logic [1:0] shift_reg_columns[3:0];  // Registros de desplazamiento para columnas

    // Sincronización de las filas de entrada
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sync_rows <= 4'b1111;           // Inicializa las filas en alto (no presionadas)
            // Reiniciar registros de desplazamiento
            for (int i = 0; i < 4; i++) begin
                shift_reg_rows[i] <= 2'b00; // Reiniciar cada registro
            end
        end else begin
            for (int i = 0; i < 4; i++) begin
                shift_reg_rows[i] <= {shift_reg_rows[i][0], async_rows[i]}; // Desplazar el registro para cada fila
            end
            sync_rows <= {shift_reg_rows[3][1], shift_reg_rows[2][1], shift_reg_rows[1][1], shift_reg_rows[0][1]}; // Salida sincronizada de filas
        end
    end

    // Sincronización de las columnas de entrada
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sync_columns <= 4'b1111;         // Inicializa las columnas en alto (no presionadas)
            // Reiniciar registros de desplazamiento
            for (int i = 0; i < 4; i++) begin
                shift_reg_columns[i] <= 2'b00; // Reiniciar cada registro
            end
        end else begin
            for (int i = 0; i < 4; i++) begin
                shift_reg_columns[i] <= {shift_reg_columns[i][0], async_columns[i]}; // Desplazar el registro para cada columna
            end
            sync_columns <= {shift_reg_columns[3][1], shift_reg_columns[2][1], shift_reg_columns[1][1], shift_reg_columns[0][1]}; // Salida sincronizada de columnas
        end
    end

endmodule
