module module_anti_rebote (
    input logic clk,                  // Reloj original a 27 MHz
    input logic rst,                  // Reset
    input logic [3:0] rows,           // Fila de entrada del teclado
    input logic [3:0] columns,        // Columna de entrada del teclado
    output logic [3:0] key_out        // Salida filtrada por fila
);

    logic [3:0] shift_reg_rows;       // Registro de desplazamiento para filas
    logic [3:0] shift_reg_columns;    // Registro de desplazamiento para columnas
    logic clk_div;                    // Reloj dividido a 1 MHz
    logic [13:0] counter;             // Contador para dividir la frecuencia

    // Contador para dividir el reloj de 27 MHz a 1 MHz
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 14'b0;           // Reiniciar el contador
            clk_div <= 1'b0;            // Inicializar el reloj dividido
        end else begin
            if (counter == 13'd13) begin 
                clk_div <= ~clk_div;     // Cambiar el estado de clk_div
                counter <= 14'b0;        // Reiniciar el contador
            end else begin
                counter <= counter + 1'b1; // Incrementar el contador
            end
        end
    end

    // Registro de desplazamiento para el anti-rebote en filas
    always_ff @(posedge clk_div or posedge rst) begin
        if (rst) begin
            shift_reg_rows <= 4'b1111;   // Inicializa el registro en alto (sin teclas presionadas)
        end else begin
            shift_reg_rows <= {shift_reg_rows[2:0], rows}; // Desplaza el registro de filas
        end
    end

    // Registro de desplazamiento para el anti-rebote en columnas
    always_ff @(posedge clk_div or posedge rst) begin
        if (rst) begin
            shift_reg_columns <= 4'b1111; // Inicializa el registro en alto (sin teclas presionadas)
        end else begin
            shift_reg_columns <= {shift_reg_columns[2:0], columns}; // Desplaza el registro de columnas
        end
    end

    // La salida es 0 si al menos uno de los bits en el registro es 0 (tecla presionada)
    always_ff @(posedge clk_div or posedge rst) begin
        if (rst) begin
            key_out <= 4'b1111; // Inicializa la salida en alto
        end else begin
            // Se utiliza la lógica para detectar teclas presionadas en filas y columnas
            key_out <= {~shift_reg_rows[3], ~shift_reg_columns[3]}; // Salida filtrada
        end
    end
endmodule
