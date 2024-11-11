module module_anti_rebote (
    input logic clk,                  
    input logic rst,                  
    input logic [3:0] row,            
    input logic [3:0] column,        
    output logic [3:0] key_out      // Cambiado a 4 bits
);

    logic [3:0] shift_reg_rows;       
    logic [3:0] shift_reg_columns;    

    // Registro de desplazamiento para el anti-rebote en filas
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg_rows <= 4'b1111;
        end else begin
            shift_reg_rows <= {shift_reg_rows[2:0], row};
        end
    end

    // Registro de desplazamiento para el anti-rebote en columnas
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg_columns <= 4'b1111;
        end else begin
            shift_reg_columns <= {shift_reg_columns[2:0], column};
        end
    end

    // Salida de 4 bits para indicar teclas presionadas en filas y columnas
    always_comb begin
        key_out = shift_reg_rows & shift_reg_columns; // Filtra filas y columnas
    end
endmodule

