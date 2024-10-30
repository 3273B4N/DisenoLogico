module module_teclado (
    input logic clk,                     // Reloj original a 27 MHz
    input logic rst,                     // Reset
    output reg [3:0] col,                // Salida de columna activa
    input logic [3:0] row,                // Fila de entrada del teclado
    output reg [7:0] first_num,          // Guarda el primer número (2 dígitos, 0-99)
    output reg [7:0] second_num          // Guarda el segundo número (2 dígitos, 0-99)
);

    typedef enum logic [1:0] {
        IDLE,        // Estado inicial
        READ_FIRST,  // Estado para leer el primer número
        READ_SECOND  // Estado para leer el segundo número
    } statetype;

    statetype state, nextstate;  
    logic [3:0] key_pressed;             // Guarda la tecla presionada
    logic [3:0] last_key;                // Guarda la última tecla presionada
    logic [1:0] count_first;             // Contador para el primer número (2 dígitos)
    logic [1:0] count_second;            // Contador para el segundo número (2 dígitos)
    logic clk_div;                       // Reloj dividido a 1 MHz
    logic [13:0] counter;                // Contador para dividir la frecuencia
    logic load_digit;                    // Señal para cargar el dígito en el número
    logic is_negative_first;             // Señal para indicar si el primer número es negativo
    logic is_negative_second;            // Señal para indicar si el segundo número es negativo

    // Contador para dividir el reloj de 27 MHz a 1 MHz
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 14'b0; 
            clk_div <= 1'b0;   
        end else begin
            if (counter == 13'd13) begin 
                clk_div <= ~clk_div; 
                counter <= 14'b0;
            end else begin
                counter <= counter + 1'b1;
            end
        end
    end

    // Señal de validación de teclas
    logic key_valid;

    // Instancia del módulo de detección de teclas
    module_teclado_detector teclado_detector_inst (
        .clk(clk_div),          
        .rst(rst),              
        .row(row),              // Invertimos la fila para reflejar la lógica pull-up
        .column(col),           
        .key_pressed(key_pressed) 
    );

    // Lógica secuencial: actualización de estado, almacenamiento de dígitos y teclas
    always_ff @(posedge clk_div or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            first_num <= 8'b0;
            second_num <= 8'b0;
            count_first <= 0;
            count_second <= 0;
            col <= 4'b1111; // Inicialmente inactivas todas las columnas
            last_key <= 4'b0000; // Sin tecla presionada al inicio
            is_negative_first <= 1'b0; // Por defecto, el número no es negativo
            is_negative_second <= 1'b0; // Por defecto, el número no es negativo
        end else begin
            state <= nextstate;
            // Si hay una tecla presionada, la almacenamos en last_key
            if (key_pressed != 4'b0000) begin
                last_key <= key_pressed;
            end
            
            // Almacenar dígitos en los números si `load_digit` está activo
            if (load_digit) begin
                case (state)
                    READ_FIRST: begin
                        if (count_first == 0)
                            first_num[3:0] <= last_key; // Primer dígito
                        else
                            first_num[7:4] <= last_key; // Segundo dígito
                        count_first <= count_first + 1;
                    end
                    READ_SECOND: begin
                        if (count_second == 0)
                            second_num[3:0] <= last_key; // Primer dígito
                        else
                            second_num[7:4] <= last_key; // Segundo dígito
                        count_second <= count_second + 1;
                    end
                endcase
            end
            
            // Verificar si se presionó la tecla 'B' después de 'A' para establecer el primer número como negativo
            if (last_key == 4'd11 && state == READ_FIRST && count_first > 0) begin // 'B' en decimales
                is_negative_first <= 1'b1; // Establece que el primer número es negativo
            end
            
            // Verificar si se presionó la tecla 'C' después de 'A' para establecer el primer número como positivo
            if (last_key == 4'd12 && state == READ_FIRST && count_first > 0) begin // 'C' en decimales
                is_negative_first <= 1'b0; // Establece que el primer número es positivo
            end
            
            // Verificar si se presionó la tecla 'B' después de 'A' para establecer el segundo número como negativo
            if (last_key == 4'd11 && state == READ_SECOND && count_second > 0) begin // 'B' en decimales
                is_negative_second <= 1'b1; // Establece que el segundo número es negativo
            end
            
            // Verificar si se presionó la tecla 'C' después de 'A' para establecer el segundo número como positivo
            if (last_key == 4'd12 && state == READ_SECOND && count_second > 0) begin // 'C' en decimales
                is_negative_second <= 1'b0; // Establece que el segundo número es positivo
            end
        end
    end

    // Lógica combinacional: cálculo de `nextstate`, `col`, y señal `load_digit`
    always_comb begin
        nextstate = state;
        col = 4'b1111;     // Todas las columnas inactivas al inicio
        load_digit = 1'b0; // Por defecto, no cargar el dígito
        
        case (state)
            IDLE: begin
                col = 4'b1110; // Habilita la primera columna
                if (key_pressed != 4'b0000) begin
                    nextstate = READ_FIRST; // Inicia la lectura del primer número
                end
            end
            READ_FIRST: begin
                col = {col[2:0], col[3]}; // Cambia de columna
                if (last_key != 4'b0000 && last_key != 4'd10) begin // Si se presiona un número diferente de "A"
                    load_digit = 1'b1; // Cargar el dígito en el primer número
                end
                // Cambiar al segundo número si el primer número tiene 2 dígitos o se presiona "A"
                if (count_first >= 2 || last_key == 4'd10) begin // Si se presiona "A", pasar a READ_SECOND
                    nextstate = READ_SECOND;
                end
            end
            READ_SECOND: begin
                col = {col[2:0], col[3]}; // Cambia de columna
                if (last_key != 4'b0000 && last_key != 4'd10) begin // Si se presiona un número diferente de "A"
                    load_digit = 1'b1; // Cargar el dígito en el segundo número
                end
                // Regresar a IDLE después de leer 2 dígitos para el segundo número
                if (count_second >= 2 || last_key == 4'd10) begin
                    nextstate = IDLE;
                    // Ajustar los números según si son negativos
                    if (is_negative_first) begin
                        first_num = -first_num; // Se invierte el primer número para hacerlo negativo
                    end
                    if (is_negative_second) begin
                        second_num = -second_num; // Se invierte el segundo número para hacerlo negativo
                    end
                end
            end
            default: nextstate = IDLE;
        endcase
    end

endmodule
