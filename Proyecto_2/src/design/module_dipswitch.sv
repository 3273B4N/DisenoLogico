module module_dipswitch (
    input logic clk,
    input logic rst,
    input logic ag, bg, cg, dg, // Entradas en código binario
    input logic button, // Botón para agregar el dígito
    output reg [11:0] first_num, // Guarda el primer número
    output reg [11:0] second_num // Guarda el segundo número
);

    typedef enum logic [2:0] {
        IDLE, // Estado inicial
        READ_FIRST, // Estado para leer el primer número
        READ_SECOND // Estado para leer el segundo número
    } statetype;

    statetype state, nextstate;  
    logic [3:0] digit; // Variable para almacenar el dígito binario
    logic [2:0] count_first; // Contador para el primer número
    logic [2:0] count_second; // Contador para el segundo número

    // Asignar las entradas directamente al dígito
    assign digit = {ag, bg, cg, dg};

    // Registro de estado
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            first_num <= 12'b0;
            second_num <= 12'b0;
            count_first <= 0;
            count_second <= 0;
        end else begin
            state <= nextstate;
        end
    end

    // Lógica del siguiente estado
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            nextstate <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (button) begin
                        nextstate <= READ_FIRST; // Inicia la lectura del primer número
                    end else begin
                        nextstate <= IDLE;
                    end
                end
                READ_FIRST: begin
                    if (button) begin
                        // Agregar el nuevo dígito al primer número
                        first_num <= {first_num[7:0], digit}; // Almacena en formato binario
                        count_first <= count_first + 1;

                        // Cambiar al segundo número si se han leído 3 dígitos
                        if (count_first == 3) begin
                            nextstate <= READ_SECOND; // Cambia al segundo número
                        end
                    end else begin
                        nextstate <= READ_FIRST; // Mantiene el estado hasta que se presione el botón
                    end
                end
                READ_SECOND: begin
                    if (button) begin
                        // Agregar el nuevo dígito al segundo número
                        second_num <= {second_num[7:0], digit}; // Almacena en formato binario
                        count_second <= count_second + 1;

                        // Volver a IDLE si se han leído 3 dígitos
                        if (count_second == 3) begin
                            nextstate <= IDLE; // Vuelve a IDLE después de leer
                        end
                    end else begin
                        nextstate <= READ_SECOND; // Mantiene el estado hasta que se presione el botón
                    end
                end
                default: nextstate <= IDLE; // Estado por defecto
            endcase
        end
    end
endmodule
