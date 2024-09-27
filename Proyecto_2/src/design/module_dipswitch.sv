module module_dipswitch (
    input logic clk,
    input logic rst,
    // Entradas del decoder
    input logic ag, bg, cg, dg, 
    output reg [11:0] first_num, // Guarda el primer número
    output reg [11:0] second_num // Guarda el segundo número
);

    typedef enum logic [2:0] {
        IDLE, // Estado inicial
        READ_FIRST, // Estado para leer el primer número
        READ_SECOND // Estado para leer el segundo número
    } statetype;

    statetype state, nextstate;  
    logic [2:0] count_first; // Contador para el primer número
    logic [2:0] count_second; // Contador para el segundo número
    logic [3:0] digit; // Variable para almacenar el dígito decodificado

    // Lógica combinacional para el decoder
    decoder decode (
        .ag(ag), 
        .bg(bg), 
        .cg(cg), 
        .dg(dg), 
        .ab(digit[3]), 
        .bb(digit[2]), 
        .cb(digit[1]), 
        .db(digit[0])
    );

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
                    // En el estado IDLE, se inicia la lectura del primer número
                    nextstate <= READ_FIRST;
                end
                READ_FIRST: begin
                    if (count_first < 3) begin
                        // Agregar el nuevo dígito decodificado
                        first_num <= {first_num[7:0], digit}; // Almacena en formato binario
                        count_first <= count_first + 1;
                    end
                    if (count_first >= 3) begin
                        nextstate <= READ_SECOND; // Cambia al segundo número
                    end else begin
                        nextstate <= READ_FIRST;
                    end
                end
                READ_SECOND: begin
                    if (count_second < 3) begin
                        // Agregar el nuevo dígito decodificado
                        second_num <= {second_num[7:0], digit}; // Almacena en formato binario
                        count_second <= count_second + 1;
                    end
                    if (count_second >= 3) begin
                        nextstate <= IDLE; // Vuelve a IDLE después de leer
                    end else begin
                        nextstate <= READ_SECOND;
                    end
                end
                default: nextstate <= IDLE; // Estado por defecto
            endcase
        end
    end

endmodule



